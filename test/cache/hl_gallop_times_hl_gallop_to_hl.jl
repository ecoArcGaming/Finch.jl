@inbounds begin
        C_lvl = ex.body.lhs.tns.tns.lvl
        C_lvl_I = C_lvl.I
        C_lvl_pos_alloc = length(C_lvl.pos)
        C_lvl_idx_alloc = length(C_lvl.idx)
        C_lvl_2 = C_lvl.lvl
        C_lvl_2_val_alloc = length(C_lvl.lvl.val)
        C_lvl_2_val = 0.0
        A_lvl = (ex.body.rhs.args[1]).tns.tns.lvl
        A_lvl_I = A_lvl.I
        A_lvl_pos_alloc = length(A_lvl.pos)
        A_lvl_idx_alloc = length(A_lvl.idx)
        A_lvl_2 = A_lvl.lvl
        A_lvl_2_val_alloc = length(A_lvl.lvl.val)
        A_lvl_2_val = 0.0
        B_lvl = (ex.body.rhs.args[2]).tns.tns.lvl
        B_lvl_I = B_lvl.I
        B_lvl_pos_alloc = length(B_lvl.pos)
        B_lvl_idx_alloc = length(B_lvl.idx)
        B_lvl_2 = B_lvl.lvl
        B_lvl_2_val_alloc = length(B_lvl.lvl.val)
        B_lvl_2_val = 0.0
        C_lvl_I = A_lvl_I
        A_lvl_I == B_lvl_I || throw(DimensionMismatch("mismatched dimension limits"))
        C_lvl_pos_alloc = length(C_lvl.pos)
        C_lvl.pos[1] = 1
        C_lvl_idx_alloc = length(C_lvl.idx)
        C_lvl_2_val_alloc = (Finch).refill!(C_lvl_2.val, 0.0, 0, 4)
        C_lvl_p_stop_2 = 1
        C_lvl_pos_alloc < C_lvl_p_stop_2 + 1 && (C_lvl_pos_alloc = (Finch).regrow!(C_lvl.pos, C_lvl_pos_alloc, C_lvl_p_stop_2 + 1))
        C_lvl_q = C_lvl.pos[1]
        A_lvl_q = A_lvl.pos[1]
        A_lvl_q_stop = A_lvl.pos[1 + 1]
        if A_lvl_q < A_lvl_q_stop
            A_lvl_i = A_lvl.idx[A_lvl_q]
            A_lvl_i1 = A_lvl.idx[A_lvl_q_stop - 1]
        else
            A_lvl_i = 1
            A_lvl_i1 = 0
        end
        B_lvl_q = B_lvl.pos[1]
        B_lvl_q_stop = B_lvl.pos[1 + 1]
        if B_lvl_q < B_lvl_q_stop
            B_lvl_i = B_lvl.idx[B_lvl_q]
            B_lvl_i1 = B_lvl.idx[B_lvl_q_stop - 1]
        else
            B_lvl_i = 1
            B_lvl_i1 = 0
        end
        i = 1
        i_start = i
        start = max(i_start, i_start)
        stop = min(A_lvl_i1, B_lvl_i1)
        start_3 = max(i_start, start)
        stop_3 = min(A_lvl_I, stop)
        if stop_3 >= start_3
            i = i
            i = start_3
            while i <= stop_3
                i_start_2 = i
                while A_lvl_q < A_lvl_q_stop && A_lvl.idx[A_lvl_q] < i_start_2
                    A_lvl_q += 1
                end
                A_lvl_i = A_lvl.idx[A_lvl_q]
                while B_lvl_q < B_lvl_q_stop && B_lvl.idx[B_lvl_q] < i_start_2
                    B_lvl_q += 1
                end
                B_lvl_i = B_lvl.idx[B_lvl_q]
                start_5 = min(i_start_2, i_start_2)
                stop_5 = max(A_lvl_i, B_lvl_i)
                start_7 = max(i_start_2, start_5)
                stop_7 = min(stop_3, stop_5)
                if stop_7 >= start_7
                    i_2 = i
                    if stop_7 == A_lvl_i && stop_7 == B_lvl_i
                        A_lvl_2_val = A_lvl_2.val[A_lvl_q]
                        B_lvl_2_val = B_lvl_2.val[B_lvl_q]
                        i_3 = stop_7
                        C_lvl_2_val_alloc < C_lvl_q && (C_lvl_2_val_alloc = (Finch).refill!(C_lvl_2.val, 0.0, C_lvl_2_val_alloc, C_lvl_q))
                        C_lvl_isdefault = true
                        C_lvl_2_val = C_lvl_2.val[C_lvl_q]
                        C_lvl_isdefault = false
                        C_lvl_isdefault = false
                        C_lvl_2_val = C_lvl_2_val + A_lvl_2_val * B_lvl_2_val
                        C_lvl_2.val[C_lvl_q] = C_lvl_2_val
                        if !C_lvl_isdefault
                            C_lvl_idx_alloc < C_lvl_q && (C_lvl_idx_alloc = (Finch).regrow!(C_lvl.idx, C_lvl_idx_alloc, C_lvl_q))
                            C_lvl.idx[C_lvl_q] = i_3
                            C_lvl_q += 1
                        end
                        A_lvl_q += 1
                        B_lvl_q += 1
                    elseif stop_7 == B_lvl_i
                        B_lvl_2_val = B_lvl_2.val[B_lvl_q]
                        i = stop_7
                        while A_lvl_q < A_lvl_q_stop && A_lvl.idx[A_lvl_q] < stop_7
                            A_lvl_q += 1
                        end
                        i_start_3 = i
                        A_lvl_i = A_lvl.idx[A_lvl_q]
                        stop_9 = min(stop_7, A_lvl_i)
                        i_4 = i
                        if A_lvl_i == stop_9
                            A_lvl_2_val = A_lvl_2.val[A_lvl_q]
                            i_5 = stop_9
                            C_lvl_2_val_alloc < C_lvl_q && (C_lvl_2_val_alloc = (Finch).refill!(C_lvl_2.val, 0.0, C_lvl_2_val_alloc, C_lvl_q))
                            C_lvl_isdefault = true
                            C_lvl_2_val = C_lvl_2.val[C_lvl_q]
                            C_lvl_isdefault = false
                            C_lvl_isdefault = false
                            C_lvl_2_val = C_lvl_2_val + A_lvl_2_val * B_lvl_2_val
                            C_lvl_2.val[C_lvl_q] = C_lvl_2_val
                            if !C_lvl_isdefault
                                C_lvl_idx_alloc < C_lvl_q && (C_lvl_idx_alloc = (Finch).regrow!(C_lvl.idx, C_lvl_idx_alloc, C_lvl_q))
                                C_lvl.idx[C_lvl_q] = i_5
                                C_lvl_q += 1
                            end
                            A_lvl_q += 1
                        else
                        end
                        i = stop_9 + 1
                        B_lvl_q += 1
                    elseif stop_7 == A_lvl_i
                        A_lvl_2_val = A_lvl_2.val[A_lvl_q]
                        i = stop_7
                        while B_lvl_q < B_lvl_q_stop && B_lvl.idx[B_lvl_q] < stop_7
                            B_lvl_q += 1
                        end
                        i_start_4 = i
                        B_lvl_i = B_lvl.idx[B_lvl_q]
                        stop_11 = min(stop_7, B_lvl_i)
                        i_6 = i
                        if B_lvl_i == stop_11
                            B_lvl_2_val = B_lvl_2.val[B_lvl_q]
                            i_7 = stop_11
                            C_lvl_2_val_alloc < C_lvl_q && (C_lvl_2_val_alloc = (Finch).refill!(C_lvl_2.val, 0.0, C_lvl_2_val_alloc, C_lvl_q))
                            C_lvl_isdefault = true
                            C_lvl_2_val = C_lvl_2.val[C_lvl_q]
                            C_lvl_isdefault = false
                            C_lvl_isdefault = false
                            C_lvl_2_val = C_lvl_2_val + A_lvl_2_val * B_lvl_2_val
                            C_lvl_2.val[C_lvl_q] = C_lvl_2_val
                            if !C_lvl_isdefault
                                C_lvl_idx_alloc < C_lvl_q && (C_lvl_idx_alloc = (Finch).regrow!(C_lvl.idx, C_lvl_idx_alloc, C_lvl_q))
                                C_lvl.idx[C_lvl_q] = i_7
                                C_lvl_q += 1
                            end
                            B_lvl_q += 1
                        else
                        end
                        i = stop_11 + 1
                        A_lvl_q += 1
                    else
                        i = start_7
                        while A_lvl_q < A_lvl_q_stop && A_lvl.idx[A_lvl_q] < start_7
                            A_lvl_q += 1
                        end
                        while B_lvl_q < B_lvl_q_stop && B_lvl.idx[B_lvl_q] < start_7
                            B_lvl_q += 1
                        end
                        while i <= stop_7
                            i_start_5 = i
                            A_lvl_i = A_lvl.idx[A_lvl_q]
                            B_lvl_i = B_lvl.idx[B_lvl_q]
                            start_13 = max(i_start_5, i_start_5)
                            stop_13 = min(A_lvl_i, B_lvl_i)
                            start_15 = max(i_start_5, start_13)
                            stop_15 = min(stop_7, stop_13)
                            if stop_15 >= start_15
                                i_8 = i
                                if A_lvl_i == stop_15 && B_lvl_i == stop_15
                                    A_lvl_2_val = A_lvl_2.val[A_lvl_q]
                                    B_lvl_2_val = B_lvl_2.val[B_lvl_q]
                                    i_9 = stop_15
                                    C_lvl_2_val_alloc < C_lvl_q && (C_lvl_2_val_alloc = (Finch).refill!(C_lvl_2.val, 0.0, C_lvl_2_val_alloc, C_lvl_q))
                                    C_lvl_isdefault = true
                                    C_lvl_2_val = C_lvl_2.val[C_lvl_q]
                                    C_lvl_isdefault = false
                                    C_lvl_isdefault = false
                                    C_lvl_2_val = C_lvl_2_val + A_lvl_2_val * B_lvl_2_val
                                    C_lvl_2.val[C_lvl_q] = C_lvl_2_val
                                    if !C_lvl_isdefault
                                        C_lvl_idx_alloc < C_lvl_q && (C_lvl_idx_alloc = (Finch).regrow!(C_lvl.idx, C_lvl_idx_alloc, C_lvl_q))
                                        C_lvl.idx[C_lvl_q] = i_9
                                        C_lvl_q += 1
                                    end
                                    A_lvl_q += 1
                                    B_lvl_q += 1
                                elseif B_lvl_i == stop_15
                                    B_lvl_2_val = B_lvl_2.val[B_lvl_q]
                                    B_lvl_q += 1
                                elseif A_lvl_i == stop_15
                                    A_lvl_2_val = A_lvl_2.val[A_lvl_q]
                                    A_lvl_q += 1
                                else
                                end
                                i = stop_15 + 1
                            end
                        end
                    end
                    i = stop_7 + 1
                end
            end
            i = stop_3 + 1
        end
        i_start = i
        start_17 = max(i_start, i_start)
        stop_17 = min(A_lvl_I, A_lvl_i1)
        if stop_17 >= start_17
            i_10 = i
            i = stop_17 + 1
        end
        i_start = i
        start_19 = max(i_start, i_start)
        stop_19 = min(A_lvl_I, B_lvl_i1)
        if stop_19 >= start_19
            i_11 = i
            i = stop_19 + 1
        end
        i_start = i
        i_12 = i
        i = A_lvl_I + 1
        C_lvl.pos[1 + 1] = C_lvl_q
        (C = Fiber((Finch.HollowListLevel){Int64}(C_lvl_I, C_lvl.pos, C_lvl.idx, C_lvl_2), (Finch.Environment)(; name = :C)),)
    end
