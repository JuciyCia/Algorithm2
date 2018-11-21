#pragma once
using namespace std;

class Group
{
public:
	friend float distance(const Group &g1,const Group& g2);
	friend void Merge(Group &g1, Group &g2);
	Group();
	Group(int id, vector<Point>& Points);
	Group(int id);

	void display()const;//��ʾgroup��ĵ���ɶ��
	void setGroupId(int id) {
		this->groupId = id;
	}
	int  getGroupId()const {
		return this->groupId;
	}
	void add(const Point&p);//�ӵ㵽group��������p���������Ϣ
	void rmv(const int i);//��vector��i����Ĩȥ
	void update();//�������ĺ��������ࣨ������
	int size()const {
		return this->Points.size();
	}//group�����
	Point getMp()const {
		return *Mp;
	}//�õ����ĵ�
	float rhormv(const Point& p)const;//����Ƴ�p�����������ܱ仯����
	float rhoadd(const Point& p)const;//�������p�����������ܱ仯����
	int inGroup(const Point&p)const;//p����������ڣ�����λ�ã����򷵻�-1
	float getJ()const;//��������
	void pop_back();
	Point back()const;
	Point at(const int i)const;

	string toString() const;


	~Group();
private:

	vector<Point> Points;
	Point *Mp;
	int groupId;
	bool updateFlag = true;
	float J = 0;
};

