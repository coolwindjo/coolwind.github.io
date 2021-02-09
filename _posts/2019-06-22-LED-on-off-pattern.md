---
title: LED On Off Pattern
layout: post
tags:
- C++
- implementation
- difference from model
---

### Source

{% highlight cpp %}

void FindViolationPatterns(vector<vii> &vviiCandLists)
{
	S[N] = 2;
	FOR(even, 2){
		vi viAB;
		ii iiCand(-1,-1);
		vii viiCandList;
		FOR(idx, N){
			const int i = (idx + even) % 2;
			viAB.push_back(i);
			CollectCand(idx, viAB, iiCand, viiCandList);
		}
		viAB.push_back(2);
		CollectCand(N, viAB, iiCand, viiCandList);

		vviiCandLists.push_back(viiCandList);
	}
}


int FindMaxLengthWithFlip(const vector<vii> &vviiCandLists)
{
	int maxLen = 0;
	FOR(i, 2){
		ii range(-1,-1);
		int nextBegin = -1;
		const int numLoops = (int)vviiCandLists.at(i).size();
		FOR(j, numLoops){
			if(j > 0){
				range.second = vviiCandLists.at(i).at(j).first;
				CheckMaxLenRange(range, maxLen);
				range.first = nextBegin;
			}
			nextBegin = vviiCandLists.at(i).at(j).second;
		}

		range.second = N;
		CheckMaxLenRange(range, maxLen);
	}
	return maxLen;
}
{% endhighlight %}

### GitHub

[LED_OnOffPattern](https://github.com/coolwindjo/RefCodes/tree/master/AlgoGuruProject/Cpp/Done/LED_OnOffPattern "LED_OnOffPattern")

![LED_OnOffPattern]({{ "/assets/img/posting/led_onoffpattern.png" | relative_url }})
