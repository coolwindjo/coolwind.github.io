---
title: Game 2048
layout: post
tags:
- C++
- implementation 
- DFS with backtracking
---

### Source

{% highlight cpp %}

	void _DFS(const vvi &map, const int numMoves, const Dir_e dir) {
		vvi movedMap(map);
#if 1
        _MoveWithQ(dir, movedMap);
#else
        _Move(dir, movedMap);
#endif // 0

		if (numMoves == MAX_MOVES)
        {
			const int biggest = GetBiggest(movedMap);
			if (biggest > m_maxVal) {
				m_maxVal = biggest;
			}
			return;
		}

		FOR(nextDir, eDIR_LEN) {
			_DFS(movedMap, numMoves + 1, (Dir_e)nextDir);
		}
	}

	int _MoveWithQ(const Dir_e dir, vvi &mapOut) {
		int numMerges = 0;
		switch (dir)
		{
		case eR:
			FOR(row, m_mapSizeN) {
				qi qiVals;
				FOR_DEC(col, 0, m_mapSizeN) {
					const int val = mapOut[row][col];
					if (val > 0) {
						mapOut[row][col] = 0;
						qiVals.push(val);
					}
				}

				FOR_DEC(col, 0, m_mapSizeN) {
					_FillCell(row, col,
							  mapOut, qiVals, numMerges);
				}
			}
			break;
		case eD:
			FOR(col, m_mapSizeN) {
				qi qiVals;
				FOR_DEC(row, 0, m_mapSizeN) {
					const int val = mapOut[row][col];
					if (val > 0) {
						mapOut[row][col] = 0;
						qiVals.push(val);
					}
				}

				FOR_DEC(row, 0, m_mapSizeN) {
					_FillCell(row, col,
							  mapOut, qiVals, numMerges);
				}
			}
			break;
		case eL:
			FOR(row, m_mapSizeN) {
				qi qiVals;
				FOR_INC(col, 0, m_mapSizeN) {
					const int val = mapOut[row][col];
					if (val > 0) {
						mapOut[row][col] = 0;
						qiVals.push(val);
					}
				}

				FOR_INC(col, 0, m_mapSizeN) {
					_FillCell(row, col,
							  mapOut, qiVals, numMerges);
				}
			}
			break;
		case eU:
			FOR(col, m_mapSizeN) {
				qi qiVals;
				FOR_INC(row, 0, m_mapSizeN) {
					const int val = mapOut[row][col];
					if (val > 0) {
						mapOut[row][col] = 0;
						qiVals.push(val);
					}
				}

				FOR_INC(row, 0, m_mapSizeN) {
					_FillCell(row, col,
							  mapOut, qiVals, numMerges);
				}
			}
			break;
		default:
			P_IFNOT(dir < eDIR_LEN, dir);
			break;
		}

		return numMerges;
	}

	void _FillCell(const int row, const int col,
				   vvi &mapOut, qi &qiValsOut, int &numMergesOut) {
		int pivotVal = -1;

		// A. visit next
		while (!qiValsOut.empty()) {
			const int val = qiValsOut.front();

			// C. check to be merged
			if (val == pivotVal) {
				mapOut[row][col] = pivotVal * 2;
				pivotVal = -1;
				numMergesOut++;
				qiValsOut.pop();
				break;
			}
			else {
				if (pivotVal != -1) {
					pivotVal = -1;
					break;
				}
			}

			// D. set pivot
			pivotVal = val;
			mapOut[row][col] = pivotVal;
			qiValsOut.pop();
		}
	}

	int _Move(const Dir_e dir, vvi &mapOut) {
		int numMerges = 0;
		switch (dir)
		{
		case eR:
			FOR(row, m_mapSizeN) {
				int pivotVal = 0;
				int pivotCol = 0;
				int emptyCellCol = 0;
				FOR_DEC(col, 0, m_mapSizeN) {
					// A. visit next
					const int val = mapOut[row][col];
					if (val > 0) {
						if (pivotVal != 0) {
							// C. check to be merged
							if (pivotVal == val) {
								mapOut[row][pivotCol] = pivotVal * 2;
								pivotVal = 0;
								mapOut[row][col] = 0;
								numMerges++;

								// G. set empty cell
								if (emptyCellCol == 0) {
									emptyCellCol = col;
								}
								continue;
							}
						}

						// D. set pivot
						pivotVal = val;
						if (emptyCellCol > 0) {
							pivotCol = emptyCellCol;

							// E. move pivot value into empty cell
							mapOut[row][emptyCellCol] = pivotVal;
							mapOut[row][col] = 0;

							// F. set next empty cell
							if (emptyCellCol > col) {
								--emptyCellCol;
							}
						}
						else {
							pivotCol = col;
						}
					}
					else {
						// B. set empty cell
						if (emptyCellCol == 0) {
							emptyCellCol = col;
						}
					}
				}
			}
			break;
		case eD:
			FOR(col, m_mapSizeN) {
				int pivotVal = 0;
				int pivotRow = 0;
				int emptyCellRow = 0;
				FOR_DEC(row, 0, m_mapSizeN) {
					// A. visit next
					const int val = mapOut[row][col];
					if (val > 0) {
						if (pivotVal != 0) {
							// C. check to be merged
							if (pivotVal == val) {
								mapOut[pivotRow][col] = pivotVal * 2;
								pivotVal = 0;
								mapOut[row][col] = 0;
								numMerges++;

								// G. set empty cell
								if (emptyCellRow == 0) {
									emptyCellRow = row;
								}
								continue;
							}
						}

						// D. set pivot
						pivotVal = val;
						if (emptyCellRow > 0) {
							pivotRow = emptyCellRow;

							// E. move pivot value into empty cell
							mapOut[emptyCellRow][col] = pivotVal;
							mapOut[row][col] = 0;

							// F. set next empty cell
							if (emptyCellRow > row) {
								--emptyCellRow;
							}
						}
						else {
							pivotRow = row;
						}
					}
					else {
						// B. set empty cell
						if (emptyCellRow == 0) {
							emptyCellRow = row;
						}
					}
				}
			}
			break;
		case eL:
			FOR(row, m_mapSizeN) {
				int pivotVal = 0;
				int pivotCol = 0;
				int emptyCellCol = m_mapSizeN;
				FOR_INC(col, 0, m_mapSizeN) {
					// A. visit next
					const int val = mapOut[row][col];
					if (val > 0) {
						if (pivotVal != 0) {
							// C. check to be merged
							if (pivotVal == val) {
								mapOut[row][pivotCol] = pivotVal * 2;
								pivotVal = 0;
								mapOut[row][col] = 0;
								numMerges++;

								// G. set empty cell
								if (emptyCellCol == m_mapSizeN) {
									emptyCellCol = col;
								}
								continue;
							}
						}

						// D. set pivot
						pivotVal = val;
						if (emptyCellCol < m_mapSizeN) {
							pivotCol = emptyCellCol;

							// E. move pivot value into empty cell
							mapOut[row][emptyCellCol] = pivotVal;
							mapOut[row][col] = 0;

							// F. set next empty cell
							if (emptyCellCol < col) {
								++emptyCellCol;
							}
						}
						else {
							pivotCol = col;
						}
					}
					else {
						// B. set empty cell
						if (emptyCellCol == m_mapSizeN) {
							emptyCellCol = col;
						}
					}
				}
			}
			break;
		case eU:
			FOR(col, m_mapSizeN) {
				int pivotVal = 0;
				int pivotRow = 0;
				int emptyCellRow = m_mapSizeN;
				FOR_INC(row, 0, m_mapSizeN) {
					// A. visit next
					const int val = mapOut[row][col];
					if (val > 0) {
						if (pivotVal != 0) {
							// C. check to be merged
							if (pivotVal == val) {
								mapOut[pivotRow][col] = pivotVal * 2;
								pivotVal = 0;
								mapOut[row][col] = 0;
								numMerges++;

								// G. set empty cell
								if (emptyCellRow == m_mapSizeN) {
									emptyCellRow = row;
								}
								continue;
							}
						}

						// D. set pivot
						pivotVal = val;
						if (emptyCellRow < m_mapSizeN) {
							pivotRow = emptyCellRow;

							// E. move pivot value into empty cell
							mapOut[emptyCellRow][col] = pivotVal;
							mapOut[row][col] = 0;

							// F. set next empty cell
							if (emptyCellRow < row) {
								++emptyCellRow;
							}
						}
						else {
							pivotRow = row;
						}
					}
					else {
						// B. set empty cell
						if (emptyCellRow == m_mapSizeN) {
							emptyCellRow = row;
						}
					}
				}
			}
			break;
		default:
			P_IFNOT(dir < eDIR_LEN, dir);
			break;
		}

		return numMerges;
	}


{% endhighlight %}

### GitHub

[Game2048](https://github.com/coolwindjo/RefCodes/tree/master/AlgoGuruProject/Cpp/Done/Game2048 "Game2048")

![Game2048]({{ "/assets/img/posting/game_2048.png" | relative_url }})
