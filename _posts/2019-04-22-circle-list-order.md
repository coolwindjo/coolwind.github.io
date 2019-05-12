---
layout: post
title: "CircleListOrder"
tags:
- C++
- circlelist
- STL
---

### GitHub
[CircleListOrder](https://github.com/coolwindjo/RefCodes/blob/master/AlgoGuruProject/Done/CircleListOrder "CircleListOrder")

![CircleListOrder]({{ "/assets/img/posting/circlelist_order.png" | relative_url }})

### Source
{% highlight cpp %}
int curN = N;
int curS = S-1;
const int constM = M-1;

li numL;
FOR(i, curN){
    numL.push_back(i+1);
}

li::iterator it = numL.begin();

FOR(i, N){
    int chosen = (curS+constM)%curN;
    
    advance(it, chosen);
    cout << *it << " ";
    numL.erase(it);
    it = numL.begin();
    
    curS = chosen;
    curN = numL.size();
}
{% endhighlight %}

