---
title: Mario game
layout: post
tags:
- C++
- implementation
- logics
---

[MarioGame](https://github.com/coolwindjo/RefCodes/blob/master/AlgoGuruProject/MarioGame "MarioGame")

![MarioGame]({{ "/assets/img/posting/mario.png" | relative_url }})

{% highlight cpp %}
const int FindMaxH(const int N, const int (&P)[MAX_N])
{
	int h = 0;
	int ud = 1;	
	for (int i=0; i<N; i++){
		if(ud == 1){
			if(P[i] > P[i+1]){
				// go down
				h += P[i];
				ud = -1;
			}
		}
		else{
			if(P[i] < P[i+1]){
				// go up
				h -= P[i];
				ud = 1;
			}
		}	
	}
	
	return h;
}
{% endhighlight %}