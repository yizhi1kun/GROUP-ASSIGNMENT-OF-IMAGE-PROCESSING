clc;clear;close all;
Input_path_ref = 'C:\Users\29314\Desktop\super-resolution-result\Set14_test\Set14_HR\';    %参考图像地址
Input_path_bic='C:\Users\29314\Desktop\super-resolution-result\Set14_test\Set14_Real-ESRGAN\';            %评价图像地址
namelist_ref = dir(strcat(Input_path_ref,'*.png'));  %获得文件夹下所有的 .png图片      参考图像名称
namelist_bic = dir(strcat(Input_path_bic,'*.png'));     %评价图像名称
len = length(namelist_ref);

for i = 1:len
    ref_name=namelist_ref(i).name;  %namelist(i).name; %这里获得的只是该路径下的文件名
    bic_name=namelist_bic(i).name;
   
    refimg=imread(strcat(Input_path_ref, ref_name)); %图片完整的路径名
    bicimg=imread(strcat(Input_path_bic, bic_name));
    refimg=double(rgb2gray(refimg));
    bicimg=double(rgb2gray(bicimg));
    [sf,sn] = compute_sf_sn(refimg, bicimg);
    sfresult(i,1)=sf;
    snresult(1,i)=sn;
    
    i    %进度条
end

sn= normalization(snresult, 0, 1, max(max(snresult)), min(min(snresult)));  
snresult=sn';

for i=1:len
    SFSN_score(i,1)=0.9*sfresult(i,1)+0.1*snresult(i,1);        %线性组合
    SFSN_score=real(SFSN_score);        %去除运算误差带来的虚部
end







