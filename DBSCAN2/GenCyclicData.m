
%GENCYCLICDATA �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
function [x] = GenCyclicData(inner_radius,band_width,num_points)
rot_deg = rand(num_points,1)*2*pi;
radius = inner_radius + band_width*rand(num_points,1);
x = [radius.*sin(rot_deg),radius.*cos(rot_deg)];
end


