---
title: Road Construction
layout: post
tags:
- C++
- Dijkstra
- STL::priority_queue
- 
---

### Source

{% highlight cpp %}

	explicit CProbSolve(const int N) {
		m_mapSizeN = N;
		m_minCost = INF;
		FOR(row, m_mapSizeN) {
			vii viiRow;
			int cnt = 0;
			while (cnt < m_mapSizeN) {
				const char cVal = cin.get();
				const int val = cVal - '0';
				if (val >= 0 && val <= 9) {
					viiRow.push_back(ii(INF, val));
					cnt++;
				}
			}
			m_map.push_back(viiRow);
		}
		_Solve();
	}

	void _Dijkstra(const ii start, const ii finish) {
		m_pqiiPos.push(i_ii(-m_map[start.first][start.second].second, start));
		while (!m_pqiiPos.empty()) {
			const i_ii cost_pos = m_pqiiPos.top(); m_pqiiPos.pop();
			const int cost = -cost_pos.first;
			const int row = cost_pos.second.first;
			const int col = cost_pos.second.second;

			// Check if it's deprecated cost
			if (cost > m_map[row][col].first) continue;

			FOR(dir, eDIR_LEN) {
				const int nextRow = row + DIR[dir][0];
				const int nextCol = col + DIR[dir][1];
				if (OOR(nextRow, 0, m_mapSizeN - 1)) continue;
				if (OOR(nextCol, 0, m_mapSizeN - 1)) continue;
				const int nextCost = cost + m_map[nextRow][nextCol].second;

				// Check if it's smaller cost
				if (nextCost >= m_map[nextRow][nextCol].first) continue;

				// Visit
				m_map[nextRow][nextCol].first = nextCost;
#if 1
				// Check if it reaches the finish point
				if ((nextRow == finish.first) && (nextCol == finish.second)) {
					m_minCost = nextCost;
					return;
				}
#endif // 1
				// Add next cell to start from
				m_pqiiPos.push(i_ii(-nextCost, ii(nextRow, nextCol)));
			}
		}

		m_minCost = m_map[finish.first][finish.second].first;
	}

{% endhighlight %}

### GitHub

[RoadConstruction](https://github.com/coolwindjo/RefCodes/tree/master/AlgoGuruProject/Cpp/Done/RoadConstruction "RoadConstruction")

![RoadConstruction]({{ "/assets/img/posting/road_construction.png" | relative_url }})
