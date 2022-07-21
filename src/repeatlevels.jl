struct RepeatLevel{Ti, Lvl}
    I::Ti
    pos::Vector{Ti}
    idx::Vector{Ti}
    lvl::Lvl
end
const Repeat = RepeatLevel
RepeatLevel(lvl) = RepeatLevel(0, lvl)
RepeatLevel{Ti}(lvl) where {Ti} = RepeatLevel(zero(Ti), lvl)
RepeatLevel(I::Ti, lvl::Lvl) where {Ti, Lvl} = RepeatLevel{Ti, Lvl}(I, lvl)
RepeatLevel{Ti}(I::Ti, lvl::Lvl) where {Ti, Lvl} = RepeatLevel{Ti, Lvl}(I, lvl)
RepeatLevel{Ti}(I::Ti, pos, idx, lvl::Lvl) where {Ti, Lvl} = RepeatLevel{Ti, Lvl}(I, pos, idx, lvl)
RepeatLevel{Ti, Lvl}(I::Ti, lvl::Lvl) where {Ti, Lvl} = RepeatLevel{Ti, Lvl}(I, Ti[1, fill(0, 16)...], Vector{Ti}(undef, 16), lvl)

parse_level(args, ::Val{:r}, words...) = Repeat(parse_level(args, words...))
summary_f_str(lvl::RepeatLevel) = "r$(summary_f_str(lvl.lvl))"
summary_f_str_args(lvl::RepeatLevel) = summary_f_str_args(lvl.lvl)
similar_level(lvl::RepeatLevel) = Repeat(similar_level(lvl.lvl))
similar_level(lvl::RepeatLevel, dim, tail...) = Repeat(dim, similar_level(lvl.lvl, tail...))

function Base.show(io::IO, lvl::RepeatLevel)
    print(io, "Repeat(")
    print(io, lvl.I)
    print(io, ", ")
    if get(io, :compact, true)
        print(io, "…")
    else
        show_region(io, lvl.pos)
        print(io, ", ")
        show_region(io, lvl.idx)
    end
    print(io, ", ")
    show(io, lvl.lvl)
    print(io, ")")
end

function display_fiber(io::IO, mime::MIME"text/plain", fbr::Fiber{<:RepeatLevel})
    p = envposition(fbr.env)
    crds = fbr.lvl.pos[p]:fbr.lvl.pos[p + 1] - 1
    depth = envdepth(fbr.env)

    print_coord(io, crd) = (print(io, "["); show(io, crd == fbr.lvl.pos[p] ? 1 : fbr.lvl.idx[crd - 1] + 1); print(io, ":"); show(io, fbr.lvl.idx[crd]); print(io, "]"))
    get_coord(crd) = fbr.lvl.idx[crd]

    print(io, "│ " ^ depth); print(io, "Repeat ("); show(IOContext(io, :compact=>true), default(fbr)); print(io, ") ["); show(io, 1); print(io, ":"); show(io, fbr.lvl.I); println(io, "]")
    display_fiber_data(io, mime, fbr, 1, crds, print_coord, get_coord)
end


@inline arity(fbr::Fiber{<:RepeatLevel}) = 1 + arity(Fiber(fbr.lvl.lvl, Environment(fbr.env)))
@inline shape(fbr::Fiber{<:RepeatLevel}) = (fbr.lvl.I, shape(Fiber(fbr.lvl.lvl, Environment(fbr.env)))...)
@inline domain(fbr::Fiber{<:RepeatLevel}) = (1:fbr.lvl.I, domain(Fiber(fbr.lvl.lvl, Environment(fbr.env)))...)
@inline image(fbr::Fiber{<:RepeatLevel}) = image(Fiber(fbr.lvl.lvl, Environment(fbr.env)))
@inline default(fbr::Fiber{<:RepeatLevel}) = default(Fiber(fbr.lvl.lvl, Environment(fbr.env)))

(fbr::Fiber{<:RepeatLevel})() = fbr
function (fbr::Fiber{<:RepeatLevel{Ti}})(i, tail...) where {D, Tv, Ti, N, R}
    lvl = fbr.lvl
    p = envposition(fbr.env)
    r = searchsortedfirst(@view(lvl.idx[lvl.pos[p]:lvl.pos[p + 1] - 1]), i)
    q = lvl.pos[p] + r - 1
    fbr_2 = Fiber(lvl.lvl, Environment(position=q, index=i, parent=fbr.env))
    return r == 0 ? default(fbr_2) : fbr_2(tail...)
end

mutable struct VirtualRepeatLevel
    ex
    Ti
    I
    pos_alloc
    idx_alloc
    lvl
end
function virtualize(ex, ::Type{RepeatLevel{Ti, Lvl}}, ctx, tag=:lvl) where {Ti, Lvl}
    sym = ctx.freshen(tag)
    I = Virtual{Int}(:($sym.I))
    pos_alloc = ctx.freshen(sym, :_pos_alloc)
    idx_alloc = ctx.freshen(sym, :_idx_alloc)
    push!(ctx.preamble, quote
        $sym = $ex
        $pos_alloc = length($sym.pos)
        $idx_alloc = length($sym.idx)
    end)
    lvl_2 = virtualize(:($sym.lvl), Lvl, ctx, sym)
    VirtualRepeatLevel(sym, Ti, I, pos_alloc, idx_alloc, lvl_2)
end
function (ctx::Finch.LowerJulia)(lvl::VirtualRepeatLevel)
    quote
        $RepeatLevel{$(lvl.Ti)}(
            $(ctx(lvl.I)),
            $(lvl.ex).pos,
            $(lvl.ex).idx,
            $(ctx(lvl.lvl)),
        )
    end
end

summary_f_str(lvl::VirtualRepeatLevel) = "r$(summary_f_str(lvl.lvl))"
summary_f_str_args(lvl::VirtualRepeatLevel) = summary_f_str_args(lvl.lvl)

getsites(fbr::VirtualFiber{VirtualRepeatLevel}) =
    [envdepth(fbr.env) + 1, getsites(VirtualFiber(fbr.lvl.lvl, VirtualEnvironment(fbr.env)))...]

function getdims(fbr::VirtualFiber{VirtualRepeatLevel}, ctx, mode)
    ext = Extent(1, fbr.lvl.I)
    if mode != Read()
        ext = suggest(ext)
    end
    (ext, getdims(VirtualFiber(fbr.lvl.lvl, VirtualEnvironment(fbr.env)), ctx, mode)...)
end

function setdims!(fbr::VirtualFiber{VirtualRepeatLevel}, ctx, mode, dim, dims...)
    fbr.lvl.I = getstop(dim)
    fbr.lvl.lvl = setdims!(VirtualFiber(fbr.lvl.lvl, VirtualEnvironment(fbr.env)), ctx, mode, dims...).lvl
    fbr
end

@inline default(fbr::VirtualFiber{<:VirtualRepeatLevel}) = default(VirtualFiber(fbr.lvl.lvl, VirtualEnvironment(fbr.env)))

function initialize_level!(fbr::VirtualFiber{VirtualRepeatLevel}, ctx::LowerJulia, mode::Union{Write, Update})
    lvl = fbr.lvl
    push!(ctx.preamble, quote
        $(lvl.pos_alloc) = length($(lvl.ex).pos)
        $(lvl.ex).pos[1] = 1
        $(lvl.idx_alloc) = length($(lvl.ex).idx)
    end)
    lvl.lvl = initialize_level!(VirtualFiber(fbr.lvl.lvl, Environment(fbr.env)), ctx, mode)
    return lvl
end

interval_assembly_depth(lvl::VirtualRepeatLevel) = Inf

#This function is quite simple, since RepeatLevels don't support reassembly.
function assemble!(fbr::VirtualFiber{VirtualRepeatLevel}, ctx, mode)
    lvl = fbr.lvl
    p_stop = ctx(cache!(ctx, ctx.freshen(lvl.ex, :_p_stop), getstop(envposition(fbr.env))))
    push!(ctx.preamble, quote
        $(lvl.pos_alloc) < ($p_stop + 1) && ($(lvl.pos_alloc) = $Finch.regrow!($(lvl.ex).pos, $(lvl.pos_alloc), $p_stop + 1))
    end)
end

function finalize_level!(fbr::VirtualFiber{VirtualRepeatLevel}, ctx::LowerJulia, mode::Union{Write, Update})
    fbr.lvl.lvl = finalize_level!(VirtualFiber(fbr.lvl.lvl, VirtualEnvironment(fbr.env)), ctx, mode)
    return fbr.lvl
end

unfurl(fbr::VirtualFiber{VirtualRepeatLevel}, ctx, mode::Read, idx, idxs...) =
    unfurl(fbr, ctx, mode, protocol(idx, walk))

function unfurl(fbr::VirtualFiber{VirtualRepeatLevel}, ctx, mode::Read, idx::Protocol{<:Any, Walk}, idxs...)
    lvl = fbr.lvl
    tag = lvl.ex
    my_i = ctx.freshen(tag, :_i)
    my_q = ctx.freshen(tag, :_q)
    my_q_stop = ctx.freshen(tag, :_q_stop)
    my_i1 = ctx.freshen(tag, :_i1)

    body = Thunk(
        preamble = (quote
            $my_q = $(lvl.ex).pos[$(ctx(envposition(fbr.env)))]
            $my_q_stop = $(lvl.ex).pos[$(ctx(envposition(fbr.env))) + 1]
            if $my_q < $my_q_stop
                $my_i = $(lvl.ex).idx[$my_q]
                $my_i1 = $(lvl.ex).idx[$my_q_stop - 1]
            else
                $my_i = 1
                $my_i1 = 0
            end
        end),
        body = Stepper(
            seek = (ctx, ext) -> quote
                #$my_q = searchsortedfirst($(lvl.ex).idx, $start, $my_q, $my_q_stop, Base.Forward)
                while $my_q < $my_q_stop && $(lvl.ex).idx[$my_q] < $(ctx(getstart(ext)))
                    $my_q += 1
                end
            end,
            body = Thunk(
                preamble = :(
                    $my_i = $(lvl.ex).idx[$my_q]
                ),
                body = Step(
                    stride = (ctx, idx, ext) -> my_i,
                    chunk = Run(
                        body = refurl(VirtualFiber(lvl.lvl, VirtualEnvironment(position=Virtual{lvl.Ti}(my_q), index=Virtual{lvl.Ti}(my_i), parent=fbr.env)), ctx, mode, idxs...)
                    ),
                    next = (ctx, idx, ext) -> quote
                        $my_q += 1
                    end
                )
            )
        )
    )

    exfurl(body, ctx, mode, idx.idx)
end

#=
unfurl(fbr::VirtualFiber{VirtualRepeatLevel}, ctx, mode::Union{Write, Update}, idx, idxs...) =
    unfurl(fbr, ctx, mode, protocol(idx, extrude), idxs...)

function unfurl(fbr::VirtualFiber{VirtualRepeatLevel}, ctx, mode::Union{Write, Update}, idx::Protocol{<:Any, Extrude}, tail...)
    lvl = fbr.lvl
    tag = lvl.ex
    my_q = ctx.freshen(tag, :_q)
    my_guard = if hasdefaultcheck(lvl.lvl)
        ctx.freshen(tag, :_isdefault)
    end

    @assert isempty(tail)

    child(q, i) = refurl(VirtualFiber(lvl.lvl, VirtualEnvironment(position=Virtual{lvl.Ti}(q), index=i, guard=my_guard, parent=fbr.env)), ctx, mode),

    body = Thunk(
        preamble = quote
            $my_q = $(lvl.ex).pos[$(ctx(envposition(fbr.env)))]
            $my_q_start = $my_q
            $my_i_prev = 0
        end,
        body = AcceptRun(
            body = (ctx, start, stop) -> Thunk(
                preamble = quote
                    $(contain(ctx) do ctx_2
                        assemble!(VirtualFiber(lvl.lvl, VirtualEnvironment(position=my_q + 1, parent=fbr.env)), ctx_2, mode)
                        quote end
                    end)
                    if $start != $my_i_prev + 1 
                        $(ctx(assign(child(my_q, call(-, start, 1), default(lvl))))
                        $(lvl.idx_alloc) < $my_q && ($(lvl.idx_alloc) = $Finch.regrow!($(lvl.ex).idx, $(lvl.idx_alloc), $my_q))
                        $(lvl.ex).idx[$my_q] = $(ctx(start)) - 1
                        $my_q += 1
                    end
                    $(
                        if hasdefaultcheck(lvl.lvl)
                            :($my_guard = true)
                        else
                            quote end
                        end
                    )
                end,
                body = child(my_q, stop)
                epilogue = begin
                    curr = child(my_q, stop)
                    prev = child(my_q - 1, call(-, start, 1))
                    body = quote
                        elseif $my_q == $my_q_start || ($prev != $curr)
                            $(lvl.idx_alloc) < $my_q && ($(lvl.idx_alloc) = $Finch.regrow!($(lvl.ex).idx, $(lvl.idx_alloc), $my_q))
                            $(lvl.ex).idx[$my_q] = $(ctx(idx))
                            $my_q += 1
                        end
                    end
                    if hasdefaultcheck(lvl.lvl) && envdefaultcheck(fbr.env) !== nothing
                        body = quote
                            if !$(my_guard)
                                $(envdefaultcheck(fbr.env)) = false
                                $body
                            end
                        end
                    end
                    body
                end
            )
        ),
        epilogue = quote
            $(lvl.ex).pos[$(ctx(envposition(fbr.env))) + 1] = $my_q
        end
    )

    exfurl(body, ctx, mode, idx.idx)
end
=#