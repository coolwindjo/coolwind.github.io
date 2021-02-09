---
title: Hiking Trail
layout: post
tags:
- C++
- DFS with backtracking
---

### Source

{% highlight cpp %}

	void _DFS(const ii& pos, const int dist, const bool bDigged) {
		// Visit!
		m_map[pos.first][pos.second].first = 1;
		const int height = m_map[pos.first][pos.second].second;

		if (dist > m_maxDist)
		{
			m_maxDist = dist;
		}

		// Check if it's a deepest point
		if (height == m_deepest)
		{
			if (bDigged == 1) {
				m_map[pos.first][pos.second].first = 0; // backtracking!
				return;
			}
		}

		if ((size_t)dist == m_mapSizeN * m_mapSizeN) {
			m_map[pos.first][pos.second].first = 0; // backtracking!
			return;
		}

		// look up 4 dirs
		FOR(dir, eDIR_LEN) {
			const ii nextPos(pos.first + DIR[dir][0], pos.second + DIR[dir][1]);
			if (OOR(nextPos.first, 0, (int)m_mapSizeN - 1)) continue;
			if (OOR(nextPos.second, 0, (int)m_mapSizeN - 1)) continue;
			if (m_map[nextPos.first][nextPos.second].first) continue;
			const int nextH = m_map[nextPos.first][nextPos.second].second;
			if (bDigged == 0) {
				// with optional digging
				if ((height - (nextH - (int)m_maxDigK)) <= 0) continue;
				int digging = height - nextH;
				if (digging <= 0) {
					P_IFNOT((1 - digging) <= (int)m_maxDigK, height);
					P_IFNOT((1 - digging) <= (int)m_maxDigK, nextH);
					P_IFNOT((1 - digging) <= (int)m_maxDigK, digging);
					m_map[nextPos.first][nextPos.second].second = nextH + (digging-1);
					_DFS(nextPos, dist + 1, 1);
					// backtracking!
					m_map[nextPos.first][nextPos.second].second = nextH;
					continue;
				}
			}
			else {
				// without digging
				if (height - nextH <= 0) continue;
			}
			_DFS(nextPos, dist + 1, bDigged);
		}

		m_map[pos.first][pos.second].first = 0; // backtracking!
	}


{% endhighlight %}

### GitHub

[HikingTrail](https://github.com/coolwindjo/RefCodes/tree/master/AlgoGuruProject/Cpp/Done/HikingTrail "HikingTrail")

![HikingTrail]({{ "/assets/img/posting/hiking_trail.png" | relative_url }})
