---
title: String Editor
layout: post
tags:
- C++
- STL
- list
---

### Source

{% highlight cpp %}

int Left(int pos){
    if (pos <= 0) return pos;
    pos--;
    itPos--;
    return pos;
}

int Right(int pos){
    if (pos >= len) return pos;
    pos++;
    itPos++;
    return pos;
}

int Del(int pos){
    if (pos <= 0) return pos;
    lc::iterator it = itPos;
    lcL.erase(--it);
    len = (int)lcL.size();
    return --pos;
}

int Ins(int pos, char alpha){
    if (pos < 0) return pos;
    if (pos > len) return pos;
    lcL.insert(itPos, alpha);
    len = (int)lcL.size();
    return ++pos;
}

void EditStr(const int numCmds){
    int pos = ParseStr();
    FOR(i, numCmds){
        char a = cmd[i];
        switch(a){
        case 1:
            pos = Left(pos);
            break;
        case 2:
            pos = Right(pos);
            break;
        case 3:
            pos = Del(pos);
            break;
        default:
            pos = Ins(pos, a);
            break;
        }
    }
}
{% endhighlight %}

### GitHub

[StringEditor](https://github.com/coolwindjo/RefCodes/tree/master/AlgoGuruProject/Cpp/Done/StringEditor "StringEditor")

![StringEditor]({{ "/assets/img/posting/string_editor.png" | relative_url }})
