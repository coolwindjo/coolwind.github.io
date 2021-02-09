---
title: Permutation Cycles
layout: post
tags:
- C++
- unordered_set
- STL
---

### Source

{% highlight cpp %}
        FOR(i, m_N){
            usi::iterator it = m_usiPerm.find(i+1);
            if(it == m_usiPerm.end()){
                continue;
            }
            m_usiPerm.erase(it);

            if (m_viPerm.at(i) == i+1){
                cycleCnt++;
            }
            else{
                int nodeFrom = i+1;
                int nodeTo = m_viPerm.at(nodeFrom-1);
                while(nodeTo != (i+1)){
                    usi::iterator delit = m_usiPerm.find(nodeTo);
                    if(W_IFNOT(delit != m_usiPerm.end()));
                    else {
                        break;
                    }
                    m_usiPerm.erase(delit);
                    nodeFrom = nodeTo;
                    nodeTo = m_viPerm.at(nodeFrom-1);
                    P_IFNOT(nodeTo <= m_N, nodeTo);
                }
                cycleCnt++;
            }
        }

{% endhighlight %}

### GitHub

[PermCycles](https://github.com/coolwindjo/RefCodes/tree/master/AlgoGuruProject/Cpp/Done/PermCycles "PermCycles")

![PermCycles]({{ "/assets/img/posting/perm_cycles.png" | relative_url }})
