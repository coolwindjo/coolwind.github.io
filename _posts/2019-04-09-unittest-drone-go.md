---
title: 'UnitTest: Drone Go'
layout: post
tags:
- C++
- implementation
- unittest
---

### GitHub (n/a)

![DroneGo]({{ "/assets/img/posting/drone_go.png" | relative_url }})

### Source
{% highlight cpp %}
/**
 * (y, x) 좌표를 표현하는 자료구조
 *
typedef struct pos {
	int y;
	int x;
} POS;

/**
 * 화재 감지 센서 인터페이스
 *
class FireSensor
{
public:
	/**
	 * 현재 화재를 감지한 센서의 위치 값을 반환
	 * @return POS 타입의 (y, x) 좌표. 예를 들어, 1번 센서에서 화재를 감지한 경우 {1, 10}을 반환
	 *
	virtual POS getSensorPosition() = 0;
};

/**
 * 드론 관제 시스템 (테스트 대상)
 *
class DroneController
{
	POS currentDrone1_ = { 0,0 };
	POS currentDrone2_ = { 10,10 };
	
	FireSensor* sensor_;
	...
public:
	DroneController(FireSensor* sensor) : sensor_(sensor) { ... }
	
	/**
	 * 화재가 발생한 위치를 얻어와서 현재 드론과의 위치를 계산하여 가장 가까운 드론을 선택하는 함수 (테스트 대상)
	 * 다음 위치 계산을 위해 선택된 드론의 위치를 저장해둔다. (선택된 드론이 해당 좌표로 이동함을 가정)
	 * @return 화재가 발생한 곳과 가장 가까운 드론의 번호. 1 혹은 2
	 *
	int selectDrone()
	{
		POS sensed = sensor_->getSensorPosition();  // 화제를 감지한 센서의 위치 획득

		int dx = currentDrone1_.x - sensed.x;
		int dy = currentDrone1_.y - sensed.y;
		int dist1 = dx*dx + dy*dy;

		dx = currentDrone2_.x - sensed.x;
		dy = currentDrone2_.y - sensed.y;
		int dist2 = dx*dx + dy*dy;

		if (dist2 >= dist1)
		{
			currentDrone1_ = sensed;
			return 1;
		}
		else
		{
			currentDrone2_ = sensed;
			return 2;
		}
	}
	...
}
{% endhighlight %}

make Stub Class

{% highlight cpp %}
// 문제 3. 테스트 코드 작성
class StubSensor: public FireSensor
{
public:
	POS m_testPos;	
	POS getSensorPosition(){
		return m_testPos;
	}
};

void test_3_1()
{
	// TODO: 항목 3-1. 
	// 화재 위치가 센서 1, 7, 2, 3, 5 순으로 감지되는 상황을 재현하는 테스트 코드
	StubSensor sensor;
	DroneController dc((FireSensor*)&sensor);
	sensor.m_testPos.y = 1; sensor.m_testPos.x = 10;
	dc.selectDrone();
	sensor.m_testPos.y = 8; sensor.m_testPos.x = 2;
	dc.selectDrone();
	sensor.m_testPos.y = 2; sensor.m_testPos.x = 6;
	dc.selectDrone();
	sensor.m_testPos.y = 4; sensor.m_testPos.x = 1;
	dc.selectDrone();
	sensor.m_testPos.y = 6; sensor.m_testPos.x = 10;
	dc.selectDrone();
}
{% endhighlight %}