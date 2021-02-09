---
title: Avoid Zeros
layout: post
tags:
- C++
- dynamic programing
- mathematics
- big number
- DFS pitfall
---

### Source

{% highlight cpp %}

	explicit CProbSolve(const int N) {
		m_minZeros = INF;
		m_mapSizeN = N;
		P_IFNOT(m_mapSizeN >= 2 , m_mapSizeN);
		P_IFNOT(m_mapSizeN <= 1000, m_mapSizeN);

		FOR(row, m_mapSizeN) {
			vii viiRow;
			vi viRow;
			FOR(col, m_mapSizeN) {
				int val = 0;
				cin >> val;
				P_IFNOT(val >= 0, val);
				int numTwos = INF;
				int numFives = INF;
				if (val > 0) {
					numTwos = _CountFactor(2, val);
					numFives = _CountFactor(5, val);
				}
				viiRow.push_back(ii(numTwos, numFives));
				viRow.push_back(val);
			}
			m_map.push_back(viiRow);
			m_mapCanGo.push_back(viRow);
		}

		_Solve();
	}

	int _CountFactor(const int factor, const int val) {
		int cnt = 0;
		int quotient = val;
		while (quotient % factor == 0) {
			quotient /= factor;
			cnt++;
		}
		return cnt;
	}

	void _UpdateFactorMap() {
		FOR_INC(row, 1, m_mapSizeN) {
			m_map[row][0].first += m_map[row - 1][0].first;
			if (m_map[row][0].first > INF) m_map[row][0].first = INF;
			m_map[row][0].second += m_map[row - 1][0].second;
			if (m_map[row][0].second > INF) m_map[row][0].second = INF;
		}
		FOR_INC(col, 1, m_mapSizeN) {
			m_map[0][col].first += m_map[0][col - 1].first;
			if (m_map[0][col].first > INF) m_map[0][col].first = INF;
			m_map[0][col].second += m_map[0][col - 1].second;
			if (m_map[0][col].second > INF) m_map[0][col].second = INF;
		}
		FOR_INC(row, 1, m_mapSizeN) {
			FOR_INC(col, 1, m_mapSizeN) {
				m_map[row][col].first += _min(m_map[row - 1][col].first, m_map[row][col - 1].first);
				if (m_map[row][col].first > INF) m_map[row][col].first = INF;
				m_map[row][col].second += _min(m_map[row - 1][col].second, m_map[row][col - 1].second);
				if (m_map[row][col].second > INF) m_map[row][col].second = INF;
			}
		}
		m_minZeros = _min(m_map[m_mapSizeN - 1][m_mapSizeN - 1].first, m_map[m_mapSizeN - 1][m_mapSizeN - 1].second);
	}

{% endhighlight %}

### GitHub

[AvoidZeros](https://github.com/coolwindjo/RefCodes/tree/master/AlgoGuruProject/Cpp/Done/AvoidZeros "AvoidZeros")

![AvoidZeros]({{ "/assets/img/posting/avoid_zeros.png" | relative_url }})
