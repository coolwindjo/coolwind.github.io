---
title: Connect Pipes
layout: post
tags:
- C++
- DFS
- BFS
- STL
- queue
---

### Source

{% highlight cpp %}
enum eDir{
	eD = 0,
	eR,
	eU,
	eL,
	NUM_DIRS
};
const int NUM_PIPE_KINDS = 12;
const int N_DIR[NUM_DIRS] = {eU, eL, eD, eR};
const int DIR[NUM_DIRS][2] = { {1,0},{0,1},{-1,0},{0,-1} };
const int CAN_GO[NUM_PIPE_KINDS][NUM_DIRS] = {
	{0,0,0,0},
	{0,1,0,1},
	{1,0,1,0},
	{1,1,0,0},
	{1,0,0,1},
	{0,0,1,1},
	{0,1,1,0},
	{1,1,1,0},
	{1,1,0,1},
	{1,0,1,1},
	{0,1,1,1},
	{1,1,1,1},
};

int visit[MAX_N][MAX_N] = {0,};
int CheckRangeFlagPipe(const ii nextPos, const int dir){
	if (visit[nextPos.first][nextPos.second] != 0) return 0;
	if (OOR(nextPos.first, 0, N-1)) return 0;
	if (OOR(nextPos.second, 0, N-1)) return 0;
	int nextDir = N_DIR[dir];
	return CAN_GO[map[nextPos.first][nextPos.second]][nextDir];
}

int cnt = 0;
void DFS(const ii pos){
	visit[pos.first][pos.second] = ++cnt;
	FOR(dir, NUM_DIRS){
		if (CAN_GO[map[pos.first][pos.second]][dir] == 0) continue;
		ii nextPos(pos.first+DIR[dir][0], pos.second+DIR[dir][1]);
		if (CheckRangeFlagPipe(nextPos, dir)){
			DFS(nextPos);
		}
	}
}

qii iiPosQ;
void BFS(const ii start){
	visit[start.first][start.second] = ++cnt;
	iiPosQ.push(start);
	while(!iiPosQ.empty()){
		ii pos = iiPosQ.front(); iiPosQ.pop();
		FOR(dir, NUM_DIRS){
			if (CAN_GO[map[pos.first][pos.second]][dir] == 0) continue;
			ii nextPos(pos.first+DIR[dir][0], pos.second+DIR[dir][1]);
			if (CheckRangeFlagPipe(nextPos, dir)){
				visit[nextPos.first][nextPos.second] = ++cnt;
				iiPosQ.push(nextPos);
			}
		}
	}
}
{% endhighlight %}

### GitHub

[ConnectPipes](https://github.com/coolwindjo/RefCodes/tree/master/AlgoGuruProject/Cpp/Done/ConnectPipes "ConnectPipes")

![ConnectPipes]({{ "/assets/img/posting/connect_pipes.png" | relative_url }})
