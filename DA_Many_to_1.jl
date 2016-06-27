
function deferred_acceptance(prop_prefs::Matrix{Int}, resp_prefs::Matrix{Int}, caps::Vector{Int})
    p = size(prop_prefs, 2)
    r = size(resp_prefs, 2)
    
    prop_matched = Array(Int, p)
    for i in 1:p
        prop_matched[i] = -1
    end
    
    resp_matched = zeros(Int, sum(caps))
    indptr = Array(Int, r+1)
    indptr[1] = 1
    for i in 1:r
        indptr[i+1] = indptr[i] + caps[i]
    end
    
    while true
        for j in 1:p
            k = 1
            while prop_matched[j] == -1
                if prop_prefs[k, j] == 0
                    prop_matched[j] = 0
                else
                    if resp_matched[indptr[prop_prefs[k,j]+1]-1] == 0
                        if findfirst(resp_prefs[:,prop_prefs[k,j]], j) < findfirst(resp_prefs[:,prop_prefs[k,j]],0)
                            resp_matched[indptr[prop_prefs[k,j]+1]-1] = j
                            prop_matched[j] = prop_prefs[k,j]
                            l = 1
                            while l <= caps[prop_prefs[k,j]] - 1
                                if findfirst(resp_prefs[:,prop_prefs[k,j]],j) < findfirst(resp_prefs[:,prop_prefs[k,j]],resp_matched
                                [indptr[prop_prefs[k,j]+1]-1-l])
                                    resp_matched[indptr[prop_prefs[k,j]+1]-l] = resp_matched[indptr[prop_prefs[k,j]+1]-1-l]
                                    resp_matched[indptr[prop_prefs[k,j]+1]-1-l] = j
                                end
                                l += 1
                            end
                        end
                    else
                        if findfirst(resp_prefs[:,prop_prefs[k,j]], j) < findfirst(resp_prefs[:,prop_prefs[k,j]],
                                resp_matched[indptr[prop_prefs[k,j]+1]-1])
                            prop_matched[resp_matched[indptr[prop_prefs[k,j]+1]-1]] = -1
                            resp_matched[indptr[prop_prefs[k,j]+1]-1] = j
                            prop_matched[j] = prop_prefs[k,j]
                            l = 1
                            while l <= caps[prop_prefs[k,j]] - 1
                                if findfirst(resp_prefs[:,prop_prefs[k,j]],j) < findfirst(resp_prefs[:,prop_prefs[k,j]],resp_matched
                                [indptr[prop_prefs[k,j]+1]-1-l])
                                    resp_matched[indptr[prop_prefs[k,j]+1]-l] = resp_matched[indptr[prop_prefs[k,j]+1]-1-l]
                                    resp_matched[indptr[prop_prefs[k,j]+1]-1-l] = j
                                end
                                l += 1
                            end
                        end 
                    end
                end
                k += 1
            end
        end
       check_matched = prop_matched[prop_matched.!= -1]
        if prop_matched == check_matched
            break
        end
    end
    return prop_matched, resp_matched, indptr
end 

function deferred_acceptance(prop_prefs::Matrix{Int}, resp_prefs::Matrix{Int})
    caps = ones(Int, size(resp_prefs, 2))
    prop_matched, resp_matched, indptr = deferred_acceptance(prop_prefs, resp_prefs, caps)
    return prop_matched, resp_matched
end


