function Fusion_image=fusion(image_1,image_2,T,sigma_r )

    sigma_s=12;


    Img1 = im2double(image_1);
    Img2 = im2double(image_2);
    
tic
    Cartoon1 = BLF_LS(Img1, Img1, sigma_s, sigma_r);
    Cartoon2 = BLF_LS(Img2, Img2, sigma_s, sigma_r); 
    Texture1=Img1-Cartoon1;
    Texture2=Img2-Cartoon2;

    
    Saliency_Texture1=Saliency_detection(im2uint8(Texture1));
    Saliency_Texture2=Saliency_detection(im2uint8(Texture2));

    Initial_Threshold_Texture1=(Saliency_Texture1>=T);
    Initial_Threshold_Texture2=(Saliency_Texture2>=T);

	Threshold_Texture1=Initial_Threshold_Texture1-Initial_Threshold_Texture1.*Initial_Threshold_Texture2;
	Threshold_Texture2=Initial_Threshold_Texture2-Initial_Threshold_Texture1.*Initial_Threshold_Texture2;
    

	Cartoon_SMLmap=(SML(Cartoon1,3)>SML(Cartoon2,3));
  
	Cartoon_Energymap=(local_energy(Cartoon1,3)>local_energy(Cartoon2,3));

    map=Cartoon_Energymap+Cartoon_SMLmap;
    
	map(map>1) = 1;
 
    Cartoon=map.*Cartoon1+~map.*Cartoon2;

    
	SOD_GF1 = RollingGuidanceFilter(Threshold_Texture1,3,0.3,4);
    SOD_GF2 = RollingGuidanceFilter(Threshold_Texture2,3,0.3,4);
    S=SOD_GF1+SOD_GF2;
    S(S>1) = 1;

    Basic_detil_1=Texture1.*(1-S);
    Basic_detil_2=Texture2.*(1-S);

    Threshold_Texture_F=Texture1.*SOD_GF1+Texture2.*SOD_GF2;

    Texture_map=(Basic_detil_1>=Basic_detil_2);
    Basic_detil_F=Texture_map.*Basic_detil_1+~Texture_map.*Basic_detil_2;
    fin_Texture=Threshold_Texture_F+Basic_detil_F;
    
    Fusion_image=Cartoon+fin_Texture;
toc

   
end
