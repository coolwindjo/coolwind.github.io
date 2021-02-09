---
title: Naming Daughter
layout: post
tags:
- C++
- BFS with generations
- unique and erase vector
---

### Source

{% highlight cpp %}


	void _BFSWithUniqueAndSmallest(const ii &start) {
		m_ans = m_map[start.first][start.second];
		m_posQ.push(start);
		while (true) {
			while (!m_posQ.empty()) {
				const ii pos = m_posQ.front(); m_posQ.pop();
				FOR(dir, eDIR_LEN) {
					const ii nextPos = ii(pos.first + DIR[dir][0], pos.second + DIR[dir][1]);
					if (OOR(nextPos.first, 0, (int)(m_rows - 1))) continue;
					if (OOR(nextPos.second, 0, (int)(m_cols - 1))) continue;
#if 0 // it works sometimes
					const string candName = m_ans + m_map[nextPos.first][nextPos.second];
					if (candName.compare(m_visit[nextPos.first][nextPos.second]) < 0) {
						m_visit[nextPos.first][nextPos.second] = candName;
						m_viiPos.push_back(nextPos);
					}
#else
					m_viiPos.push_back(nextPos);
#endif // 0
				}
			}
			m_viiPos.erase(unique(m_viiPos.begin(), m_viiPos.end()), m_viiPos.end());
			const int numCands = m_viiPos.size();
			if (numCands == 0) return;

			char earlistC = m_map[m_viiPos[0].first][m_viiPos[0].second];
			FOR_INC(i, 1, numCands) {
				const char ch = m_map[m_viiPos[i].first][m_viiPos[i].second];
				if (ch < earlistC) {
					earlistC = ch;
				}
			}
			m_ans.push_back(earlistC);
			if ((m_viiPos.front().first == (int)(m_rows - 1)) && (m_viiPos.front().second == (int)(m_cols - 1))) {
				return;
			}

			FOR(i, numCands) {
				if (m_map[m_viiPos[i].first][m_viiPos[i].second] == earlistC) {
					m_posQ.push(m_viiPos[i]);
				}
			}
			m_viiPos.clear();
		}
	}

{% endhighlight %}

### GitHub

[NamingDaughter](https://github.com/coolwindjo/RefCodes/tree/master/AlgoGuruProject/Cpp/Done/NamingDaughter "NamingDaughter")

![NamingDaughter]({{ "/assets/img/posting/naming_daughter.png" | relative_url }})
