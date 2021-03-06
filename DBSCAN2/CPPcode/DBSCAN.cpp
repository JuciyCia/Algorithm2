// ConsoleApplication1.cpp : 此文件包含 "main" 函数。程序执行将在此处开始并结束。
//

#include "pch.h"
using namespace std;

int main(int argc, char *argv[])
{	//默认参数
	int MinPits = MINPITS;
	float eps = EPS;
	int Num = NUM;
	string fileinPath = "points.txt";
	string fileoutPath = "classedPoints.txt";




	if (argc == 6) {
		fileinPath = argv[1];//输入文件
		fileoutPath = argv[2];//输出文件

		MinPits = atoi(argv[3]);
		eps = atof(argv[4]);
		Num = atoi(argv[5]);
		cout << "MinPits = " <<MinPits<< "  eps = " <<eps<<" num = "<<Num<< endl;
	}
	else {
		cout << "传参出错，使用默认参数" << endl;
	}
	vector<Point> Points;//先把所有点放到vector里
	ifstream fin(fileinPath);//读文件 == in.open()
	if (!fin.is_open())
	{
		cout << "error in inputfile !";
		exit(1);
	}
	else {
		cout << "载入点集合成功"<<endl<<endl;
	}
	/*----------从文件读到内存NUM个点---------------*/
	float x1, x2;
	int id = 0;
	while (!fin.eof() && id < Num)
	{
		fin >> x1 >> x2;
		Point p(id, x1, x2);//每次都在新的定义
		Points.push_back(p);//调用复制构造函数
		id++;
	}
	fin.close();
	//

	/*聚类核心代码*/
	vector<Group> Groups;
	vector<Group> nGroups;//未分类点集合链
	vector<Point> corePoints;
	for (int i = 0; i < Points.size(); i++) {//遍历所有待分类点
		Group g;

		g.add(Points.at(i));//如果这个簇保留下来，那么首次进去的点就是核心点
		for (int j = 0; j < Points.size(); j++) {
			if (i == j)continue;
			if ((Points.at(i) - Points.at(j)).l2() < eps) {//如果pi pj两点间的欧式距离小于eps
				g.add(Points.at(j));//将pj加入到pi所在的集合
			}
		}
		if (g.size() > MinPits) {//如果这个临时样本集合的点数大于MinPits，
			Groups.push_back(g);//就将该集合加入到临时簇的列表里，
			corePoints.push_back(Points.at(i));//将这个点加入核心点集合
		}


	}

	/*已经分为了很多Groups，而且每个groups里的点是有重复的*/
	//根据定义，密度相连的两个点则为一个类，也就是说如果两个簇Groups[i], Gourps[j]内有重复的点，则要聚为一类
	vector<vector<int>> array2d;
	for (int i = 0; i < Groups.size(); i++) {
		vector<int > array;
		array.push_back(i);
		for (int j = 0; j < Groups.size(); j++) {
			if (i == j)continue;
			if ((Groups.at(i).at(0) - Groups.at(j).at(0)).l2() < eps) {//0就是该簇的核心点
				array.push_back(j);//如果两个核心点距离小于eps则加到一个链内
			}

		}
		array2d.push_back(array);

	}

	/*将较大的数据结构抽象成了2d数组，可以省掉大量开销*/
	for (int i = 0; i < array2d.size(); i++) {//先排序
		sort(array2d[i].begin(), array2d[i].end());
	}

	Intersection_of_two_array2d(array2d);//如果两个数组有交集，合并,j倒进i里面，然后j清空


	
	ofstream fout(fileoutPath);//读文件 == in.open()
	if (!fout.is_open())
	{
		cout << "error in classedPoints.txt";
		getchar();//让dos停留观测结果用，可删除
		exit(1);
	}

	/*输出到文件*/
	int cnt = 0;
	vector<int>rem(Num, 0);//记录表，以防重复写入文件

	
	for (int i = 0; i < array2d.size(); i++) {//这里是已经分类的点
		if (array2d.at(i).size() == 0)continue;
		for (int j = 0; j < array2d.at(i).size(); j++) {
			int temp = array2d.at(i).at(j);
			for (int m = 0; m < Groups[temp].size(); m++) {
				Point p = Groups[temp].at(m);
				if (rem.at(p.getPointId()) == 0) {//如果没写过
					fout << cnt << " "
						<< p.getX1() << " "
						<< p.getX2() << " "
						<< endl;
#ifdef DEBUG
					cout << cnt << " "
						<< p.getX1() << " "
						<< p.getX2() << " "
						<< endl;

#endif // DEBUG

					
					rem.at(p.getPointId()) = 1;//登记一下，省的重复写
				}
				
				
			}
			
			//这里写文件
		}
		cnt++;
		
	}
	cout << "--------------------------";

	for (int i = 0; i < Points.size(); i++) {//这里输出未分类点，组为0
		if (rem.at(i) == 0) {
			Point p = Points.at(i);
			fout << cnt << " "
				<< p.getX1() << " "
				<< p.getX2() << " "
				<< endl;
#ifdef DEBUG
			cout << cnt << " "
				<< p.getX1() << " "
				<< p.getX2() << " "
				<< endl;
#endif // DEBUG
		}
	}





	fout.close();
	


	cout << endl << "操作成功,分类数量： "<<cnt << endl;
	return 1;
}

