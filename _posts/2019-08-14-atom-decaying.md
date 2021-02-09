---
title: Atom Decaying
layout: post
tags:
- C++
- implementation
- sort
- unique and erase vector
- STL::stack
- STL::priority_queue
---

### Source

{% highlight cpp %}

	explicit CProbSolve(const int N) {
		m_numAtomsN = N;
		FOR(i, eDIR_LEN){
			vi viEmpty;
			m_vviAtomIdx.push_back(viEmpty);
		}
		FOR(atIdx, m_numAtomsN) {
			int x, y, dir, enrg;
			cin >> x >> y >> dir >> enrg;
			m_vAtoms.push_back(Atom(x, y, dir, enrg));
			m_vviAtomIdx[dir].push_back(atIdx);
		}
		_Solve();
	}

	void _Solve() {
		// Find orthogonal crashes of earlier time than the times of relative atoms
		_FindOrthoCrash();
		_FindLinearCrash();

		// Sum up the energy of atoms with the limited time
		const int energySum = _SumUpEnergy();
		cout << energySum << "\n";
	}

	void _FindOrthoCrash()
	{
		for(int atI : m_vviAtomIdx[eD]) {
			for(int atJ : m_vviAtomIdx[eR]) {
				const Atom_t &at1 = m_vAtoms[atI];
				const Atom_t &at2 = m_vAtoms[atJ];
				const int xVector = at1.x - at2.x;
				const int yVector = at1.y - at2.y;
				if (xVector == yVector) {
					const int dbldTime = 2 * xVector;
					m_vCrashes.push_back(Crash(dbldTime, ii(atI, atJ)));
				}
			}
		}
		for(int atI : m_vviAtomIdx[eL]) {
			for(int atJ : m_vviAtomIdx[eU]) {
				const Atom_t &at1 = m_vAtoms[atI];
				const Atom_t &at2 = m_vAtoms[atJ];
				const int xVector = at1.x - at2.x;
				const int yVector = at1.y - at2.y;
				if (xVector == yVector) {
					const int dbldTime = 2 * xVector;
					m_vCrashes.push_back(Crash(dbldTime, ii(atI, atJ)));
				}
			}
		}
		for(int atI : m_vviAtomIdx[eD]) {
			for(int atJ : m_vviAtomIdx[eL]) {
				const Atom_t &at1 = m_vAtoms[atI];
				const Atom_t &at2 = m_vAtoms[atJ];
				const int xVector = at2.x - at1.x;
				const int yVector = at1.y - at2.y;
				if (xVector == yVector) {
					const int dbldTime = 2 * xVector;
					m_vCrashes.push_back(Crash(dbldTime, ii(atI, atJ)));
				}
			}
		}
		for(int atI : m_vviAtomIdx[eR]) {
			for(int atJ : m_vviAtomIdx[eU]) {
				const Atom_t &at1 = m_vAtoms[atI];
				const Atom_t &at2 = m_vAtoms[atJ];
				const int xVector = at2.x - at1.x;
				const int yVector = at1.y - at2.y;
				if (xVector == yVector) {
					const int dbldTime = 2 * xVector;
					m_vCrashes.push_back(Crash(dbldTime, ii(atI, atJ)));
				}
			}
		}


	}

	void _FindLinearCrash()
	{
		for(int atI : m_vviAtomIdx[eD]) {
			for(int atJ : m_vviAtomIdx[eU]) {
				const Atom_t &at1 = m_vAtoms[atI];
				const Atom_t &at2 = m_vAtoms[atJ];
				const int xVector = at1.x - at2.x;
				if (xVector != 0) continue;
		
				const int yVector = at1.y - at2.y;
				if (yVector > 0) {
					const int dbldTime = yVector;
					m_vCrashes.push_back(Crash(dbldTime, ii(atI, atJ)));
				}
			}
		}
		for(int atI : m_vviAtomIdx[eL]) {
			for(int atJ : m_vviAtomIdx[eR]) {
				const Atom_t &at1 = m_vAtoms[atI];
				const Atom_t &at2 = m_vAtoms[atJ];
				const int yVector = at1.y - at2.y;
				if (yVector != 0) continue;

				const int xVector = at1.x - at2.x;
				if (xVector > 0) {
					const int dbldTime = xVector;
					m_vCrashes.push_back(Crash(dbldTime, ii(atI, atJ)));
				}
			}
		}
	}

	int _SumUpEnergy() {
		int enrgSum = 0;
		sort(m_vCrashes.begin(), m_vCrashes.end());
		m_vCrashes.erase(unique(m_vCrashes.begin(), m_vCrashes.end()), m_vCrashes.end());
		const int numCrashes = (int)m_vCrashes.size();
		FOR(crIdx, numCrashes) {
			const Crash dbldTime_at1at2 = m_vCrashes[crIdx];
			Atom_t &atm1 = m_vAtoms[dbldTime_at1at2.second.first];
			Atom_t &atm2 = m_vAtoms[dbldTime_at1at2.second.second];
			const int dbldTime = dbldTime_at1at2.first;
			if ((atm1.enrg < 0) && (atm1.enrg != -dbldTime)) continue;
			if ((atm2.enrg < 0) && (atm2.enrg != -dbldTime)) continue;
			if (atm1.enrg > 0) {
				enrgSum += atm1.enrg;
				atm1.enrg = -dbldTime;
			}
			if (atm2.enrg > 0) {
				enrgSum += atm2.enrg;
				atm2.enrg = -dbldTime;
			}
		}
		return enrgSum;
	}

#ifdef PQII
	void _FindLinearCrash(pqii & pqiiSortedList)
	{
		stack<ii> atmS;
		while (!pqiiSortedList.empty()) {
			const ii XorY_atIdx = pqiiSortedList.top(); pqiiSortedList.pop();
			const Atom_t atm = m_vAtoms[XorY_atIdx.second];
			if (!atmS.empty()) {
				const ii prev_XorY_atIdx = atmS.top();
				// filter out duplicate atom index
				if (XorY_atIdx.second == prev_XorY_atIdx.second) continue;
				const Atom_t prev_atm = m_vAtoms[prev_XorY_atIdx.second];
				const int dbldTime = prev_XorY_atIdx.first - XorY_atIdx.first;
				if ((prev_atm.dir == eD) || (prev_atm.dir == eL)) {
					if ((atm.dir == eU) || (atm.dir == eR)) {
						const int smallerIdx = min(XorY_atIdx.second, prev_XorY_atIdx.second);
						const int biggerIdx = max(XorY_atIdx.second, prev_XorY_atIdx.second);
						m_vCrashes.push_back(Crash(dbldTime, ii(smallerIdx, biggerIdx)));
						atmS.pop();
						continue;
					}
				}
			}
			atmS.push(XorY_atIdx);
		}
	}
#endif // PQII

{% endhighlight %}

### GitHub

[AtomDecaying](https://github.com/coolwindjo/RefCodes/tree/master/AlgoGuruProject/Cpp/Done/AtomDecaying "AtomDecaying")

![AtomDecaying]({{ "/assets/img/posting/atom_decaying.png" | relative_url }})
