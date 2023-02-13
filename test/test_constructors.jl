@testset "fiber constructors" begin
    using Base.Meta

    @testset "@fiber(sl(e(0))" begin
        io = IOBuffer()
        arr = [0.0, 2.0, 2.0, 0.0, 3.0, 3.0]

        println(io, "@fiber(sl(e(0)) constructors:")

        fbr = dropdefaults!(Fiber!(SparseList(Element(zero(eltype(arr))))), arr)
        println(io, "initialized fiber: ", fbr)
        lvl = fbr.lvl
        @test isstructequal(fbr, Fiber(SparseList(lvl.lvl, lvl.I, lvl.pos, lvl.idx)))
        @test isstructequal(fbr, Fiber(SparseList{Int}(lvl.lvl, lvl.I, lvl.pos, lvl.idx)))

        fbr = dropdefaults!(Fiber!(SparseList{Int16}(Element(zero(eltype(arr))))), arr)
        println(io, "initialized fiber: ", fbr)
        lvl = fbr.lvl
        @test isstructequal(fbr, Fiber(SparseList{Int16}(lvl.lvl, lvl.I, lvl.pos, lvl.idx)))

        fbr = Fiber!(SparseList(Element(0.0), 7))
        println(io, "sized fiber: ", fbr)
        lvl = fbr.lvl
        @test isstructequal(fbr, Fiber!(SparseList(Element(0.0), 7)))
        @test isstructequal(fbr, Fiber!(SparseList{Int}(Element(0.0), 7)))
        @test isstructequal(fbr, @fiber(sl(e(0.0), 7)))
        @test isstructequal(fbr, @fiber(sl{Int}(e(0.0), 7)))

        fbr = Fiber!(SparseList{Int16}(Element(0.0), 7))
        println(io, "sized fiber: ", fbr)
        lvl = fbr.lvl
        @test isstructequal(fbr, Fiber!(SparseList(Element(0.0), Int16(7))))
        @test isstructequal(fbr, Fiber!(SparseList{Int16}(Element(0.0), 7)))
        @test isstructequal(fbr, @fiber(sl(e(0.0), Int16(7))))
        @test isstructequal(fbr, @fiber(sl{Int16}(e(0.0), 7)))

        fbr = Fiber!(SparseList(Element(0.0)))
        println(io, "empty fiber: ", fbr)
        lvl = fbr.lvl
        @test isstructequal(fbr, Fiber!(SparseList(Element(0.0))))
        @test isstructequal(fbr, Fiber!(SparseList{Int}(Element(0.0))))
        @test isstructequal(fbr, Fiber!(SparseList(Element(0.0), 0)))
        @test isstructequal(fbr, Fiber!(SparseList{Int}(Element(0.0), 0)))
        @test isstructequal(fbr, @fiber(sl(e(0.0))))
        @test isstructequal(fbr, @fiber(sl{Int}(e(0.0))))
        @test isstructequal(fbr, @fiber(sl(e(0.0), 0)))
        @test isstructequal(fbr, @fiber(sl{Int}(e(0.0), 0)))

        fbr = Fiber!(SparseList{Int16}(Element(0.0)))
        println(io, "empty fiber: ", fbr)
        lvl = fbr.lvl
        @test isstructequal(fbr, Fiber!(SparseList{Int16}(Element(0.0))))
        @test isstructequal(fbr, Fiber!(SparseList(Element(0.0), Int16(0))))
        @test isstructequal(fbr, Fiber!(SparseList{Int16}(Element(0.0), 0)))
        @test isstructequal(fbr, @fiber(sl{Int16}(e(0.0))))
        @test isstructequal(fbr, @fiber(sl(e(0.0), Int16(0))))
        @test isstructequal(fbr, @fiber(sl{Int16}(e(0.0), 0)))

        @test check_output("format_constructors_sl_e.txt", String(take!(io)))
    end

    @testset "@fiber(sv(e(0))" begin
        io = IOBuffer()
        arr = [0.0, 2.0, 2.0, 0.0, 3.0, 3.0]

        println(io, "@fiber(sv(e(0)) constructors:")

        fbr = dropdefaults!(Fiber!(SparseVBL(Element(zero(eltype(arr))))), arr)
        println(io, "initialized fiber: ", fbr)
        lvl = fbr.lvl
        @test isstructequal(fbr, Fiber(SparseVBL(lvl.lvl, lvl.I, lvl.pos, lvl.idx, lvl.ofs)))
        @test isstructequal(fbr, Fiber(SparseVBL{Int}(lvl.lvl, lvl.I, lvl.pos, lvl.idx, lvl.ofs)))

        fbr = dropdefaults!(Fiber!(SparseVBL{Int16}(Element(zero(eltype(arr))))), arr)
        println(io, "initialized fiber: ", fbr)
        lvl = fbr.lvl
        @test isstructequal(fbr, Fiber(SparseVBL{Int16}(lvl.lvl, lvl.I, lvl.pos, lvl.idx, lvl.ofs)))

        fbr = Fiber!(SparseVBL(Element(0.0), 7))
        println(io, "sized fiber: ", fbr)
        lvl = fbr.lvl
        @test isstructequal(fbr, Fiber!(SparseVBL(Element(0.0), 7)))
        @test isstructequal(fbr, Fiber!(SparseVBL{Int}(Element(0.0), 7)))
        @test isstructequal(fbr, @fiber(sv(e(0.0), 7)))
        @test isstructequal(fbr, @fiber(sv{Int}(e(0.0), 7)))

        fbr = Fiber!(SparseVBL{Int16}(Element(0.0), 7))
        println(io, "sized fiber: ", fbr)
        lvl = fbr.lvl
        @test isstructequal(fbr, Fiber!(SparseVBL(Element(0.0), Int16(7))))
        @test isstructequal(fbr, Fiber!(SparseVBL{Int16}(Element(0.0), 7)))
        @test isstructequal(fbr, @fiber(sv(e(0.0), Int16(7))))
        @test isstructequal(fbr, @fiber(sv{Int16}(e(0.0), 7)))

        fbr = Fiber!(SparseVBL(Element(0.0)))
        println(io, "empty fiber: ", fbr)
        lvl = fbr.lvl
        @test isstructequal(fbr, Fiber!(SparseVBL(Element(0.0))))
        @test isstructequal(fbr, Fiber!(SparseVBL{Int}(Element(0.0))))
        @test isstructequal(fbr, Fiber!(SparseVBL(Element(0.0), 0)))
        @test isstructequal(fbr, Fiber!(SparseVBL{Int}(Element(0.0), 0)))
        @test isstructequal(fbr, @fiber(sv(e(0.0))))
        @test isstructequal(fbr, @fiber(sv{Int}(e(0.0))))
        @test isstructequal(fbr, @fiber(sv(e(0.0), 0)))
        @test isstructequal(fbr, @fiber(sv{Int}(e(0.0), 0)))

        fbr = Fiber!(SparseVBL{Int16}(Element(0.0)))
        println(io, "empty fiber: ", fbr)
        lvl = fbr.lvl
        @test isstructequal(fbr, Fiber!(SparseVBL{Int16}(Element(0.0))))
        @test isstructequal(fbr, Fiber!(SparseVBL(Element(0.0), Int16(0))))
        @test isstructequal(fbr, Fiber!(SparseVBL{Int16}(Element(0.0), 0)))
        @test isstructequal(fbr, @fiber(sv{Int16}(e(0.0))))
        @test isstructequal(fbr, @fiber(sv(e(0.0), Int16(0))))
        @test isstructequal(fbr, @fiber(sv{Int16}(e(0.0), 0)))

        @test check_output("format_constructors_sv_e.txt", String(take!(io)))
    end

    @testset "@fiber(sm(e(0))" begin
        io = IOBuffer()
        arr = [0.0, 2.0, 2.0, 0.0, 3.0, 3.0]

        println(io, "@fiber(sm(e(0)) constructors:")

        fbr = dropdefaults!(Fiber!(SparseBytemap(Element(zero(eltype(arr))))), arr)
        println(io, "initialized fiber: ", fbr)
        lvl = fbr.lvl
        @test isstructequal(fbr, Fiber(SparseBytemap(lvl.lvl, lvl.I, lvl.pos, lvl.tbl, lvl.srt)))
        @test isstructequal(fbr, Fiber(SparseBytemap{Int}(lvl.lvl, lvl.I, lvl.pos, lvl.tbl, lvl.srt)))

        fbr = dropdefaults!(Fiber!(SparseBytemap{Int16}(Element(zero(eltype(arr))))), arr)
        println(io, "initialized fiber: ", fbr)
        lvl = fbr.lvl
        @test isstructequal(fbr, Fiber(SparseBytemap{Int16}(lvl.lvl, lvl.I, lvl.pos, lvl.tbl, lvl.srt)))

        fbr = Fiber!(SparseBytemap(Element(0.0), 7))
        println(io, "sized fiber: ", fbr)
        lvl = fbr.lvl
        @test isstructequal(fbr, Fiber!(SparseBytemap(Element(0.0), 7)))
        @test isstructequal(fbr, Fiber!(SparseBytemap{Int}(Element(0.0), 7)))
        @test isstructequal(fbr, @fiber(sm(e(0.0), 7)))
        @test isstructequal(fbr, @fiber(sm{Int}(e(0.0), 7)))

        fbr = Fiber!(SparseBytemap{Int16}(Element(0.0), 7))
        println(io, "sized fiber: ", fbr)
        lvl = fbr.lvl
        @test isstructequal(fbr, Fiber!(SparseBytemap(Element(0.0), Int16(7))))
        @test isstructequal(fbr, Fiber!(SparseBytemap{Int16}(Element(0.0), 7)))
        @test isstructequal(fbr, @fiber(sm(e(0.0), Int16(7))))
        @test isstructequal(fbr, @fiber(sm{Int16}(e(0.0), 7)))

        fbr = Fiber!(SparseBytemap(Element(0.0)))
        println(io, "empty fiber: ", fbr)
        lvl = fbr.lvl
        @test isstructequal(fbr, Fiber!(SparseBytemap(Element(0.0))))
        @test isstructequal(fbr, Fiber!(SparseBytemap{Int}(Element(0.0))))
        @test isstructequal(fbr, Fiber!(SparseBytemap(Element(0.0), 0)))
        @test isstructequal(fbr, Fiber!(SparseBytemap{Int}(Element(0.0), 0)))
        @test isstructequal(fbr, @fiber(sm(e(0.0))))
        @test isstructequal(fbr, @fiber(sm{Int}(e(0.0))))
        @test isstructequal(fbr, @fiber(sm(e(0.0), 0)))
        @test isstructequal(fbr, @fiber(sm{Int}(e(0.0), 0)))

        fbr = Fiber!(SparseBytemap{Int16}(Element(0.0)))
        println(io, "empty fiber: ", fbr)
        lvl = fbr.lvl
        @test isstructequal(fbr, Fiber!(SparseBytemap{Int16}(Element(0.0))))
        @test isstructequal(fbr, Fiber!(SparseBytemap(Element(0.0), Int16(0))))
        @test isstructequal(fbr, Fiber!(SparseBytemap{Int16}(Element(0.0), 0)))
        @test isstructequal(fbr, @fiber(sm{Int16}(e(0.0))))
        @test isstructequal(fbr, @fiber(sm(e(0.0), Int16(0))))
        @test isstructequal(fbr, @fiber(sm{Int16}(e(0.0), 0)))

        @test check_output("format_constructors_sm_e.txt", String(take!(io)))
    end

    @testset "@fiber(sc{1}(e(0))" begin
        io = IOBuffer()
        arr = [0.0, 2.0, 2.0, 0.0, 3.0, 3.0]

        println(io, "@fiber(sc{1}(e(0)) constructors:")

        fbr = dropdefaults!(Fiber!(SparseCoo{1}(Element(zero(eltype(arr))))), arr)
        println(io, "initialized fiber: ", fbr)
        lvl = fbr.lvl
        @test isstructequal(fbr, Fiber(SparseCoo{1}(lvl.lvl, lvl.I, lvl.tbl, lvl.pos)))
        @test isstructequal(fbr, Fiber(SparseCoo{1, Tuple{Int}}(lvl.lvl, lvl.I, lvl.tbl, lvl.pos)))

        fbr = dropdefaults!(Fiber!(SparseCoo{1, Tuple{Int16}}(Element(zero(eltype(arr))))), arr)
        println(io, "initialized fiber: ", fbr)
        lvl = fbr.lvl
        @test isstructequal(fbr, Fiber(SparseCoo{1, Tuple{Int16}}(lvl.lvl, lvl.I, lvl.tbl, lvl.pos)))

        fbr = Fiber!(SparseCoo{1}(Element(0.0), (7,)))
        println(io, "sized fiber: ", fbr)
        lvl = fbr.lvl
        @test isstructequal(fbr, Fiber!(SparseCoo{1}(Element(0.0), (7,))))
        @test isstructequal(fbr, Fiber!(SparseCoo{1, Tuple{Int}}(Element(0.0), (7,))))
        @test isstructequal(fbr, @fiber(sc{1}(e(0.0), (7,))))
        @test isstructequal(fbr, @fiber(sc{1, Tuple{Int}}(e(0.0), (7,))))

        fbr = Fiber!(SparseCoo{1, Tuple{Int16}}(Element(0.0), 7))
        println(io, "sized fiber: ", fbr)
        lvl = fbr.lvl
        @test isstructequal(fbr, Fiber!(SparseCoo{1}(Element(0.0), (Int16(7),))))
        @test isstructequal(fbr, Fiber!(SparseCoo{1, Tuple{Int16}}(Element(0.0), (7,))))
        @test isstructequal(fbr, @fiber(sc{1}(e(0.0), (Int16(7),))))
        @test isstructequal(fbr, @fiber(sc{1, Tuple{Int16}}(e(0.0), 7)))

        fbr = Fiber!(SparseCoo{1}(Element(0.0)))
        println(io, "empty fiber: ", fbr)
        lvl = fbr.lvl
        @test isstructequal(fbr, Fiber!(SparseCoo{1}(Element(0.0))))
        @test isstructequal(fbr, Fiber!(SparseCoo{1, Tuple{Int}}(Element(0.0))))
        @test isstructequal(fbr, Fiber!(SparseCoo{1}(Element(0.0), (0,))))
        @test isstructequal(fbr, Fiber!(SparseCoo{1, Tuple{Int}}(Element(0.0), (0,))))
        @test isstructequal(fbr, @fiber(sc{1}(e(0.0))))
        @test isstructequal(fbr, @fiber(sc{1, Tuple{Int}}(e(0.0))))
        @test isstructequal(fbr, @fiber(sc{1}(e(0.0), (0,))))
        @test isstructequal(fbr, @fiber(sc{1, Tuple{Int}}(e(0.0), (0,))))

        fbr = Fiber!(SparseCoo{1, Tuple{Int16}}(Element(0.0)))
        println(io, "empty fiber: ", fbr)
        lvl = fbr.lvl
        @test isstructequal(fbr, Fiber!(SparseCoo{1, Tuple{Int16}}(Element(0.0))))
        @test isstructequal(fbr, Fiber!(SparseCoo{1}(Element(0.0), (Int16(0),))))
        @test isstructequal(fbr, Fiber!(SparseCoo{1, Tuple{Int16}}(Element(0.0), (0,))))
        @test isstructequal(fbr, @fiber(sc{1, Tuple{Int16}}(e(0.0))))
        @test isstructequal(fbr, @fiber(sc{1}(e(0.0), (Int16(0),))))
        @test isstructequal(fbr, @fiber(sc{1, Tuple{Int16}}(e(0.0), (0,))))

        @test check_output("format_constructors_sc1_e.txt", String(take!(io)))
    end

    @testset "@fiber(sc{2}(e(0))" begin
        io = IOBuffer()
        arr = [0.0 2.0 2.0 0.0 3.0 3.0;
               1.0 0.0 7.0 1.0 0.0 0.0;
               0.0 0.0 0.0 0.0 0.0 9.0]

        println(io, "@fiber(sc{2}(e(0)) constructors:")

        fbr = dropdefaults!(Fiber!(SparseCoo{2}(Element(zero(eltype(arr))))), arr)
        println(io, "initialized fiber: ", fbr)
        lvl = fbr.lvl
        @test isstructequal(fbr, Fiber(SparseCoo{2}(lvl.lvl, lvl.I, lvl.tbl, lvl.pos)))
        @test isstructequal(fbr, Fiber(SparseCoo{2, Tuple{Int, Int}}(lvl.lvl, lvl.I, lvl.tbl, lvl.pos)))

        fbr = dropdefaults!(Fiber!(SparseCoo{2, Tuple{Int16, Int16}}(Element(zero(eltype(arr))))), arr)
        println(io, "initialized fiber: ", fbr)
        lvl = fbr.lvl
        @test isstructequal(fbr, Fiber(SparseCoo{2, Tuple{Int16, Int16}}(lvl.lvl, lvl.I, lvl.tbl, lvl.pos)))

        fbr = Fiber!(SparseCoo{2}(Element(0.0), (3, 7)))
        println(io, "sized fiber: ", fbr)
        lvl = fbr.lvl
        @test isstructequal(fbr, Fiber!(SparseCoo{2}(Element(0.0), (3, 7,))))
        @test isstructequal(fbr, Fiber!(SparseCoo{2, Tuple{Int, Int}}(Element(0.0), (3, 7,))))
        @test isstructequal(fbr, @fiber(sc{2}(e(0.0), (3, 7,))))
        @test isstructequal(fbr, @fiber(sc{2, Tuple{Int, Int}}(e(0.0), (3, 7,))))

        fbr = Fiber!(SparseCoo{2, Tuple{Int16, Int16}}(Element(0.0), (3, 7)))
        println(io, "sized fiber: ", fbr)
        lvl = fbr.lvl
        @test isstructequal(fbr, Fiber!(SparseCoo{2}(Element(0.0), (Int16(3), Int16(7),))))
        @test isstructequal(fbr, Fiber!(SparseCoo{2, Tuple{Int16, Int16}}(Element(0.0), (3, 7,))))
        @test isstructequal(fbr, @fiber(sc{2}(e(0.0), (Int16(3), Int16(7),),)))
        @test isstructequal(fbr, @fiber(sc{2, Tuple{Int16, Int16}}(e(0.0), (3, 7,))))

        fbr = Fiber!(SparseCoo{2}(Element(0.0)))
        println(io, "empty fiber: ", fbr)
        lvl = fbr.lvl
        @test isstructequal(fbr, Fiber!(SparseCoo{2}(Element(0.0))))
        @test isstructequal(fbr, Fiber!(SparseCoo{2, Tuple{Int, Int}}(Element(0.0))))
        @test isstructequal(fbr, Fiber!(SparseCoo{2}(Element(0.0), (0,0,))))
        @test isstructequal(fbr, Fiber!(SparseCoo{2, Tuple{Int, Int}}(Element(0.0), (0,0,))))
        @test isstructequal(fbr, @fiber(sc{2}(e(0.0))))
        @test isstructequal(fbr, @fiber(sc{2, Tuple{Int, Int}}(e(0.0))))
        @test isstructequal(fbr, @fiber(sc{2}(e(0.0), (0,0,))))
        @test isstructequal(fbr, @fiber(sc{2, Tuple{Int, Int}}(e(0.0), (0,0,))))

        fbr = Fiber!(SparseCoo{2, Tuple{Int16, Int16}}(Element(0.0)))
        println(io, "empty fiber: ", fbr)
        lvl = fbr.lvl
        @test isstructequal(fbr, Fiber!(SparseCoo{2, Tuple{Int16, Int16}}(Element(0.0))))
        @test isstructequal(fbr, Fiber!(SparseCoo{2}(Element(0.0), (Int16(0), Int16(0),))))
        @test isstructequal(fbr, Fiber!(SparseCoo{2, Tuple{Int16, Int16}}(Element(0.0), (0,0))))
        @test isstructequal(fbr, @fiber(sc{2, Tuple{Int16, Int16}}(e(0.0))))
        @test isstructequal(fbr, @fiber(sc{2}(e(0.0), (Int16(0), Int16(0),))))
        @test isstructequal(fbr, @fiber(sc{2, Tuple{Int16, Int16}}(e(0.0), (0,0,))))

        @test check_output("format_constructors_sc2_e.txt", String(take!(io)))
    end

    @testset "@fiber(sh{1}(e(0))" begin
        io = IOBuffer()
        arr = [0.0, 2.0, 2.0, 0.0, 3.0, 3.0]

        println(io, "@fiber(sh{1}(e(0)) constructors:")

        fbr = dropdefaults!(Fiber!(SparseHash{1}(Element(zero(eltype(arr))))), arr)
        println(io, "initialized fiber: ", fbr)
        lvl = fbr.lvl
        @test isstructequal(fbr, Fiber(SparseHash{1}(lvl.lvl, lvl.I, lvl.tbl, lvl.pos, lvl.srt)))
        @test isstructequal(fbr, Fiber(SparseHash{1, Tuple{Int}}(lvl.lvl, lvl.I, lvl.tbl, lvl.pos, lvl.srt)))

        fbr = dropdefaults!(Fiber!(SparseHash{1, Tuple{Int16}}(Element(zero(eltype(arr))))), arr)
        println(io, "initialized fiber: ", fbr)
        lvl = fbr.lvl
        @test isstructequal(fbr, Fiber(SparseHash{1, Tuple{Int16}}(lvl.lvl, lvl.I, lvl.tbl, lvl.pos, lvl.srt)))

        fbr = Fiber!(SparseHash{1}(Element(0.0), (7,)))
        println(io, "sized fiber: ", fbr)
        lvl = fbr.lvl
        @test isstructequal(fbr, Fiber!(SparseHash{1}(Element(0.0), (7,))))
        @test isstructequal(fbr, Fiber!(SparseHash{1, Tuple{Int}}(Element(0.0), (7,))))
        @test isstructequal(fbr, @fiber(sh{1}(e(0.0), (7,))))
        @test isstructequal(fbr, @fiber(sh{1, Tuple{Int}}(e(0.0), (7,))))

        fbr = Fiber!(SparseHash{1, Tuple{Int16}}(Element(0.0), (7,)))
        println(io, "sized fiber: ", fbr)
        lvl = fbr.lvl
        @test isstructequal(fbr, Fiber!(SparseHash{1}(Element(0.0), (Int16(7),))))
        @test isstructequal(fbr, Fiber!(SparseHash{1, Tuple{Int16}}(Element(0.0), (7,))))
        @test isstructequal(fbr, @fiber(sh{1}(e(0.0), (Int16(7),))))
        @test isstructequal(fbr, @fiber(sh{1, Tuple{Int16}}(e(0.0), (7,))))

        fbr = Fiber!(SparseHash{1}(Element(0.0)))
        println(io, "empty fiber: ", fbr)
        lvl = fbr.lvl
        @test isstructequal(fbr, Fiber!(SparseHash{1}(Element(0.0))))
        @test isstructequal(fbr, Fiber!(SparseHash{1, Tuple{Int}}(Element(0.0))))
        @test isstructequal(fbr, Fiber!(SparseHash{1}(Element(0.0), (0,))))
        @test isstructequal(fbr, Fiber!(SparseHash{1, Tuple{Int}}(Element(0.0), (0,))))
        @test isstructequal(fbr, @fiber(sh{1}(e(0.0))))
        @test isstructequal(fbr, @fiber(sh{1, Tuple{Int}}(e(0.0))))
        @test isstructequal(fbr, @fiber(sh{1}(e(0.0), (0,))))
        @test isstructequal(fbr, @fiber(sh{1, Tuple{Int}}(e(0.0), (0,))))

        fbr = Fiber!(SparseHash{1, Tuple{Int16}}(Element(0.0)))
        println(io, "empty fiber: ", fbr)
        lvl = fbr.lvl
        @test isstructequal(fbr, Fiber!(SparseHash{1, Tuple{Int16}}(Element(0.0))))
        @test isstructequal(fbr, Fiber!(SparseHash{1}(Element(0.0), (Int16(0),))))
        @test isstructequal(fbr, Fiber!(SparseHash{1, Tuple{Int16}}(Element(0.0), (0,))))
        @test isstructequal(fbr, @fiber(sh{1, Tuple{Int16}}(e(0.0))))
        @test isstructequal(fbr, @fiber(sh{1}(e(0.0), (Int16(0),))))
        @test isstructequal(fbr, @fiber(sh{1, Tuple{Int16}}(e(0.0), (0,))))

        @test check_output("format_constructors_sh1_e.txt", String(take!(io)))
    end

    @testset "@fiber(sh{2}(e(0))" begin
        io = IOBuffer()
        arr = [0.0 2.0 2.0 0.0 3.0 3.0;
               1.0 0.0 7.0 1.0 0.0 0.0;
               0.0 0.0 0.0 0.0 0.0 9.0]

        println(io, "@fiber(sh{2}(e(0)) constructors:")

        fbr = dropdefaults!(Fiber!(SparseHash{2}(Element(zero(eltype(arr))))), arr)
        println(io, "initialized fiber: ", fbr)
        lvl = fbr.lvl
        @test isstructequal(fbr, Fiber(SparseHash{2}(lvl.lvl, lvl.I, lvl.tbl, lvl.pos, lvl.srt)))
        @test isstructequal(fbr, Fiber(SparseHash{2, Tuple{Int, Int}}(lvl.lvl, lvl.I, lvl.tbl, lvl.pos, lvl.srt)))

        fbr = dropdefaults!(Fiber!(SparseHash{2, Tuple{Int16, Int16}}(Element(zero(eltype(arr))))), arr)
        println(io, "initialized fiber: ", fbr)
        lvl = fbr.lvl
        @test isstructequal(fbr, Fiber(SparseHash{2, Tuple{Int16, Int16}}(lvl.lvl, lvl.I, lvl.tbl, lvl.pos, lvl.srt)))

        fbr = Fiber!(SparseHash{2}(Element(0.0), (3, 7)))
        println(io, "sized fiber: ", fbr)
        lvl = fbr.lvl
        @test isstructequal(fbr, Fiber!(SparseHash{2}(Element(0.0), (3, 7,))))
        @test isstructequal(fbr, Fiber!(SparseHash{2, Tuple{Int, Int}}(Element(0.0), (3, 7,))))
        @test isstructequal(fbr, @fiber(sh{2}(e(0.0), (3, 7,))))
        @test isstructequal(fbr, @fiber(sh{2, Tuple{Int, Int}}(e(0.0), (3, 7,))))

        fbr = Fiber!(SparseHash{2, Tuple{Int16, Int16}}(Element(0.0), (3, 7)))
        println(io, "sized fiber: ", fbr)
        lvl = fbr.lvl
        @test isstructequal(fbr, Fiber!(SparseHash{2}(Element(0.0), (Int16(3), Int16(7),))))
        @test isstructequal(fbr, Fiber!(SparseHash{2, Tuple{Int16, Int16}}(Element(0.0), (3, 7,))))
        @test isstructequal(fbr, @fiber(sh{2}(e(0.0), (Int16(3), Int16(7),))))
        @test isstructequal(fbr, @fiber(sh{2, Tuple{Int16, Int16}}(e(0.0), (3, 7,))))

        fbr = Fiber!(SparseHash{2}(Element(0.0)))
        println(io, "empty fiber: ", fbr)
        lvl = fbr.lvl
        @test isstructequal(fbr, Fiber!(SparseHash{2}(Element(0.0))))
        @test isstructequal(fbr, Fiber!(SparseHash{2, Tuple{Int, Int}}(Element(0.0))))
        @test isstructequal(fbr, Fiber!(SparseHash{2}(Element(0.0), (0,0,))))
        @test isstructequal(fbr, Fiber!(SparseHash{2, Tuple{Int, Int}}(Element(0.0), (0,0,))))
        @test isstructequal(fbr, @fiber(sh{2}(e(0.0))))
        @test isstructequal(fbr, @fiber(sh{2, Tuple{Int, Int}}(e(0.0))))
        @test isstructequal(fbr, @fiber(sh{2}(e(0.0), (0,0,))))
        @test isstructequal(fbr, @fiber(sh{2, Tuple{Int, Int}}(e(0.0), (0,0,))))

        fbr = Fiber!(SparseHash{2, Tuple{Int16, Int16}}(Element(0.0)))
        println(io, "empty fiber: ", fbr)
        lvl = fbr.lvl
        @test isstructequal(fbr, Fiber!(SparseHash{2, Tuple{Int16, Int16}}(Element(0.0))))
        @test isstructequal(fbr, Fiber!(SparseHash{2}(Element(0.0), (Int16(0), Int16(0),))))
        @test isstructequal(fbr, Fiber!(SparseHash{2, Tuple{Int16, Int16}}(Element(0.0), (0,0))))
        @test isstructequal(fbr, @fiber(sh{2, Tuple{Int16, Int16}}(e(0.0))))
        @test isstructequal(fbr, @fiber(sh{2}(e(0.0), (Int16(0), Int16(0),))))
        @test isstructequal(fbr, @fiber(sh{2, Tuple{Int16, Int16}}(e(0.0), (0,0,))))

        @test check_output("format_constructors_sh2_e.txt", String(take!(io)))
    end

end