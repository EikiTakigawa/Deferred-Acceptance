
function Match(m_prefs, n_prefs)
    m = size(m_prefs,2)
    n = size(n_prefs,2)
    m_matched = Array(Int,m)
    for i in 1:m
        m_matched[i] = -1
    end
    n_matched = zeros(Int,n)
    while true
        for j in 1:m
            k = 1
            while m_matched[j] == -1
                if m_prefs[k, j] == 0
                    m_matched[j] = 0
                else
                    if n_matched[m_prefs[k, j]] == 0
                        if findfirst(n_prefs[:, m_prefs[k,j]] , j) < findfirst(n_prefs[:, m_prefs[k,j]], 0)
                            n_matched[m_prefs[k, j]] = j
                            m_matched[j] = m_prefs[k, j]
                        end
                    else
                        if findfirst(n_prefs[:, m_prefs[k,j]], j) < findfirst(n_prefs[: ,m_prefs[k,j]], n_matched[m_prefs[k,j]])
                            m_matched[n_matched[m_prefs[k,j]]] = -1
                            n_matched[m_prefs[k,j]] = j
                            m_matched[j] = m_prefs[k,j]
                        end
                    end
                end
                k += 1
            end
        end
        check_matched = m_matched[m_matched.!= -1]
        if m_matched == check_matched
            break
        end
    end
    return m_matched,n_matched
end
