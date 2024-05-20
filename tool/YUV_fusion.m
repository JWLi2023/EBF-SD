function Fusion_image=YUV_fusion(gray_image,color_image,T,sigma_r)
    [row,column]=size(gray_image);
    
    Fusion_image=zeros(row,column,3);
    if size(gray_image,3)>1
        gray_image=rgb2gray(gray_image);             
    end
    gray_image = im2double(gray_image);
    color_image = im2double(color_image);
    
    
	Color_image_YUV=ConvertRGBtoYUV(color_image);  
    

    Color_image_Y=Color_image_YUV(:,:,1);  


    Fusion_V=fusion(gray_image,Color_image_Y,T,sigma_r);
    

    Fusion_image(:,:,1)=Fusion_V;
    Fusion_image(:,:,2)=Color_image_YUV(:,:,2);
    Fusion_image(:,:,3)=Color_image_YUV(:,:,3);
    
    Fusion_image=ConvertYUVtoRGB(Fusion_image);
end