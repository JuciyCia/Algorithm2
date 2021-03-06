// ConsoleApplication1.cpp : 此文件包含 "main" 函数。程序执行将在此处开始并结束。
//

#include "pch.h"
using namespace std;
#define NUM 100
#define nC 5
#define INIT_SIZE_OF_GROUP 20

int main(int argc, char *argv[])
{
	
	string fileinPath;
	if (argc == 1) {
		cout << "输入点集文件失败！使用默认文件名称" << endl;
	 fileinPath = "points.txt";
	}
	else {
		fileinPath = argv[1];//输入文件
	}
	vector<Point> Points;
	vector<Group> Groups;//初始化五个类
	ifstream fin(fileinPath);//读文件 == in.open()
	if (!fin.is_open())
	{
		cout << "error in inputfile !";
		getchar();//让dos停留观测结果用，可删除
		exit(1);
	}
	/*----------从文件读到内存100个点---------------*/
	float x1, x2;
	int id = 0;
	while (!fin.eof()&&id<NUM)
	{
		fin >> x1 >> x2 ;
		Point p(id,x1, x2);//每次都在新的定义
		
		Points.push_back(p);//调用复制构造函数
		id++;

	}
	fin.close();
	/*-------------------*/
	for (int i = 0; i < nC; i++) {
		Group g(i);
		for (int j = 0; j < INIT_SIZE_OF_GROUP; j++) {
			g.add(Points.back());
			Points.pop_back();
		}
		Groups.push_back(g);
		
	}

	
	for (int i = 0; i < nC; i++){
		Groups[i].update();
		//Groups[i].display();
		
	}
	
	
	
	//cout << "操作之后" << endl << endl;

	int cnt = 0;
	vector<float>Je;
	while (cnt< ITERATE_MAX) {
		float rho1 = 0, rho2 = 0;
		int tok = 0;
		vector<Point>::iterator Ite;
		bool flag = false;

		for (int i = 0; i < Groups.size(); i++) {//选择一个集合
			for (int j = 0; j < Groups[i].size(); j++) {//从该集合内选择一个点
				Point p = Groups[i].at(j);//pop
				rho1 = Groups[i].rhormv(p);
				//选取group第一个点，依次试着放到其他group试下
				for (int k = 0; k < Groups.size(); k++) {
					if (k == p.getBelongto()) continue;
					rho2 = Groups[k].rhoadd(p);
					if (rho1 > rho2) {
						rho1 = rho2;
						tok = k;
						flag = true;
					}
				}
				if (flag == true) {
					Groups[tok].add(p);//把选到的点放到该集合中。	
					Groups[i].rmv(j);//把点删除；
					Groups[tok].update();
					Groups[i].update();
					float je = 0;
					for (int m = 0; m < Groups.size(); m++) {
						je += Groups[m].getJ();
					}
					
					Je.push_back(je);
					cnt++;
					j--;//从删除的位置继续
					flag = false;

					if (cnt>2&&abs(Je[Je.size()/2] - Je[Je.size()-1]) < delta&&cnt>ITERATE_MIN) {
						cnt = ITERATE_MAX;
					}

				}

			}
		}
	
	}
	/*
	//控制台查看
	for (int i = 0; i < nC; i++) {
		Groups[i].display();
	}
	for (int i = 0; i < Je.size(); i++) {
		cout << " " << Je.at(i);
	}
	cout << endl << "迭代次数 :" << Je.size() << " Je = " << Je.back() << endl;;
	
	*/

	string fileOutPath = OUTFILE1;
	ofstream fout(fileOutPath);//读文件 == in.open()
	if (!fout.is_open())
	{
		cout << "error in out1.txt";
		getchar();//让dos停留观测结果用，可删除
		exit(1);
	}
	
	
	for (int i = 0; i < Groups.size(); i++) {
		for (int j = 0; j < Groups[i].size(); j++) {
			fout << Groups[i].at(j).getBelongto()<<" "
				<< Groups[i].at(j).getX1() << " "
				<< Groups[i].at(j).getX2() << " "
				 << endl;
		}
		
	}
	fout.close();
	fout.open(OUTFILE2);
	if (!fout.is_open())
	{	cout << "error in out2.txt !";
		exit(1);
	}
	
	for (int i = 0; i < Je.size(); i++) {
		fout << Je.at(i) << " " ;
	}

	return 1;
}

// 运行程序: Ctrl + F5 或调试 >“开始执行(不调试)”菜单
// 调试程序: F5 或调试 >“开始调试”菜单

// 入门提示: 
//   1. 使用解决方案资源管理器窗口添加/管理文件
//   2. 使用团队资源管理器窗口连接到源代码管理
//   3. 使用输出窗口查看生成输出和其他消息
//   4. 使用错误列表窗口查看错误
//   5. 转到“项目”>“添加新项”以创建新的代码文件，或转到“项目”>“添加现有项”以将现有代码文件添加到项目
//   6. 将来，若要再次打开此项目，请转到“文件”>“打开”>“项目”并选择 .sln 文件
