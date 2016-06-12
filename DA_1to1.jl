
function Match(m, n, m_prefs, n_prefs)
    m_matched = zeros(m)
    n_matched = zeros(n)
    i = 1
    for i in 1:n+1
        k = 1
        for k in 1:m
            if m_prefs[i, k] == 0
                m_prefs[i:end, k] = 0
            else
                if m_matched[k] == 0
                    if n_matched[m_prefs[i, k]] == 0
                        if findfirst(n_prefs[:, m_prefs[i,k]] , k) < findfirst(n_prefs[:, m_prefs[i,k]], 0)
                            n_matched[m_prefs[i, k]] = k
                            m_matched[k] = m_prefs[i, k]
                        end
                    else
                        if findfirst(n_prefs[:, m_prefs[i,k]], k) < findfirst(n_prefs[: ,m_prefs[i,k]], n_matched[m_prefs[i,k]])
                            m_matched[n_matched[m_prefs[i,k]]] = 0
                            n_matched[m_prefs[i,k]] = k
                            m_matched[k] = m_prefs[i,k]
                        end
                    end
                end
            end
            k += 1
        end
        i += 1
    end
    return m_matched, n_matched
end
