// 层次聚类.cpp : 此文件包含 "main" 函数。程序执行将在此处开始并结束。
//

#include "pch.h"

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

	vector<Point> Points;//先把所有点放到vector里
	ifstream fin(fileinPath);//读文件 == in.open()
	if (!fin.is_open())
	{
		cout << "error in inputfile !";
		exit(1);
	}
	else {
		cout << "载入点集合成功" << endl << endl;
	}
	/*----------从文件读到内存NUM个点---------------*/
	float x1, x2;
	int id = 0;
	while (!fin.eof() && id < NUM)
	{
		fin >> x1 >> x2;
		Point p(id+1, x1, x2);//每次都在新的定义
		Points.push_back(p);//调用复制构造函数

		id++;
	}
	fin.close();
	//初始化组，每个点一个组

	vector<Group>Groups;
	for (int i = 0; i < Points.size(); i++) {
		Group g(i);
		g.add(Points[i]);
		g.setGroupId(Points[i].getPointId());
		g.update();
		Groups.push_back(g);
	}

	//2
	vector<vector<float>>promixity;//邻近、距离矩阵
	for (int i = 0; i < NUM; i++) {
		vector<float>temp(1+i, 0);//0行为空
		promixity.push_back(temp);
	}
	//写入距离
	for (int i = 0; i < NUM; i++) {
		for (int j = 0; j < promixity[i].size(); j++) {
			if (i == j)continue;
			promixity[i][j] = distance(Groups[i], Groups[j]);
			//cout << promixity[i][j];
		}
		//cout << endl;
	}
	float temp = INF;
	int tempi = 0, tempj = 0;
	
	int initNum = Groups.size();
	int cnt = 0;

	

	vector<vector<float>>mat;
	while (initNum > CLASS_NUM) {//一次举一个类
		for (int i = 0; i < NUM; i++) {
			for (int j = 0; j < promixity[i].size(); j++) {
				if (i == j)continue;
				if (promixity[i][j] == INF)continue;

				if (promixity[i][j] < temp) {
					temp = promixity[i][j];
					tempi = i;
					tempj = j;
				}
			}
		}
		
		
		if (tempj < tempi) {
			int swap = tempj;
			tempj = tempi;
			tempi = swap;
		}
		Merge(Groups[tempi], Groups[tempj]);//把j倒进i
		vector<float>tempvec(3, 0);
		tempvec[0] = Groups[tempi].getGroupId();
		tempvec[1] = Groups[tempj].getGroupId();
		tempvec[2] = temp;
		mat.push_back(tempvec);//记录树，到时候输出为文件在matlab上画图
		temp = INF;
		cnt++;
		Groups[tempi].setGroupId(NUM + cnt);
		Groups[tempi].update();
		Groups[tempj].update();
		initNum--;

		//重写矩阵,把消去的group那一行换成INF
		for (int i = 0; i < promixity[tempj].size(); i++) {
			promixity[tempj][i] = INF;
		}
	
		for (int i = 0; i < promixity.size(); i++) {//把消去的group那一列换成INF
			if (tempj < promixity[i].size()) {
				promixity[i][tempj] = INF;
			}
		}
		//把所有组队tempi的距离列更新
		for (int i = 0; i < NUM; i++) {
			if (tempi >= promixity[i].size())continue;
			
			promixity[i][tempi] = distance(Groups[tempi], Groups[i]);
		
		}
		//行更新
		for (int i = 0; i < promixity[tempi].size(); i++) {
			if (promixity[tempi][i] == INF)continue;
			promixity[tempi][i] = distance(Groups[tempi], Groups[i]);
		}
		//一次聚合后的距离矩阵输出
		/*
		for (int i = 0; i < NUM; i++) {
			for (int j = 0; j < promixity[i].size(); j++) {
				if (i == j)continue;
				promixity[i][j] = distance(Groups[i], Groups[j]);
				if (promixity[i][j] == INF)cout << "INF ";
				else cout << promixity[i][j] << " ";
			}
			cout << endl;
		}
		*/
	}//while
	//控制台测试输出
	for (int i = 0; i < mat.size(); i++) {
		for (int j = 0; j < mat[i].size(); j++) {
			cout << mat[i][j] << " ";
		}cout << endl;
	}

	for (int i = 0; i < Groups.size(); i++) {
		if (Groups[i].size() == 0)continue;
		cout << Groups[i].toString();
	}
	//输出文件mat
	string fileOutPath = OUTFILE1;
	ofstream fout(fileOutPath);//读文件 == in.open()
	if (!fout.is_open())
	{
		cout << "error in out1.txt";
		return -1;
		exit(1);
	}


	for (int i = 0; i < mat.size(); i++) {
		fout << mat[i][0] << " " << mat[i][1] << " " << mat[i][2]<<endl;
	

	}
	fout.close();

	

	return 0;
}
