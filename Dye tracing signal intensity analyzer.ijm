///////////////////////////////////////////////////////////////////////////
//            'Dye Tracing Singnal Intensity Analyzer'                   //
//  This is the imageJ macro that is allow to maesure the signal         //
//  intensity from Dye tracing images. Applicable Images have to be      //
//  Red and Green merged image. Blue signal is ignored.                  //
//	The images have to be applied by user. User need to choose the       //
//  color you want to measure the intensity of signal. if User need to   //
//  make the given plots smmother, Just select the values for Gaussian   //
//  from Dialog tha t pops up when this macro start up.                  //
//  Given value of signal intensity will be normalized. So the values    //
// 	are within the range between 0-1.                                    //
//                                                                       //
//                                       Written by Sho Ota @ 07/27/2021 //
//                                                                       //
// @07/28/2021 : wrong scaling in graph Bug fixed                        //
//                                                                       //
///////////////////////////////////////////////////////////////////////////






///////////////  Dialog initial setting by User ////////////////
colors = newArray("Green", "Red");
g_filter= newArray("none", "3x3", "5x5", "7x7")
Dialog.create("Initial Setting");

Dialog.addChoice("Color of Signal:", colors);
Dialog.addChoice("Gaussian filter:", g_filter);
Dialog.addCheckbox("Black background", false);
Dialog.show();

sig_col= Dialog.getChoice();
g_fil= Dialog.getChoice();
bl_b= Dialog.getCheckbox()
///////////////////////////////////////////////////////////////

print(sig_col)
print(g_fil)
print(bl_b)


////// Let User open the image ////////
ori_title= getTitle();

///// Split Channel and Delete iamge except the image that User choose //////
run("Split Channels");


//// If User choose Green /////////
if(sig_col=='Green'){
	selectWindow(ori_title+" (red)");
	close();
	selectWindow(ori_title+" (blue)");
	close();
	selectWindow(ori_title+" (green)");

	//////  Gaussian filter set up ////////////
	if(g_fil== "3x3"){
	run("Gaussian Blur...", "sigma=3");
	}
	
	if(g_fil== "5x5"){
		run("Gaussian Blur...", "sigma=5");
	}
	
	if(g_fil== "7x7"){
		run("Gaussian Blur...", "sigma=7");
	}else{
		print("none");
	}

	//// Change Image properties x=1.0, y= 1.0, z= 1.0 /////
	run("Properties...", "channels=1 slices=1 frames=1 unit=µm pixel_width=1.0 pixel_height=1.0 voxel_depth=1.0");
	
	waitForUser("Select area by rectangle tool or restore selection");  //wait for user action
	
	run("Plots...", "width=600 height=340 font=14 draw_ticks minimum=0 maximum=0 vertical interpolate");
	run("Plot Profile");
	Plot.getValues(x, y);
	Array.print(x);
	Array.print(y);
	//x= newArray(10, 28, 5, 67, 4, 6);
	
	//// Find minimum /////
	Vmin= 10000000000;
	for(i=0; i<lengthOf(y); i++){
		if(y[i]<Vmin){
			Vmin= y[i];
		}
	}
	
	print(Vmin);
	
	//// Find minimum /////
	Vmax= 0;
	for(i=0; i<lengthOf(y); i++){
		if(y[i]>Vmax){
			Vmax= y[i];
		}
	}
	
	print(Vmax);
	
	/// Normalize data_y /////
	for(i=0; i<lengthOf(y);i++){
		y[i]=(y[i]-Vmin)/Vmax;
	}
	
	Array.print(y);
	
	/// Normalize data_x  ////
	for(i=0; i<lengthOf(x);i++){
		x[i]=(x[i]-0)/lengthOf(x);
	}
	
	Array.print(x);
	
	
	
	
	
	
	Plot.create("Title_Green signal (normalized)", "relative position", "relative signal intensity", x, y)
	Plot.setLogScaleX(false);
	Plot.setLogScaleY(false);
	Plot.setLimits(0.000,1.000,0.000,1.000);
	Plot.setStyle(0, "Green,none,2.0,Line");
	if(bl_b== true){
		Plot.setBackgroundColor("black");
	}
}

//// If User choose Red /////////
if(sig_col=='Red'){
	selectWindow(ori_title+" (green)");
	close();
	selectWindow(ori_title+" (blue)");
	close();
	selectWindow(ori_title+" (red)");

	//////  Gaussian filter set up ////////////
	if(g_fil== "3x3"){
	run("Gaussian Blur...", "sigma=3");
	}
	
	if(g_fil== "5x5"){
		run("Gaussian Blur...", "sigma=5");
	}
	
	if(g_fil== "7x7"){
		run("Gaussian Blur...", "sigma=7");
	}else{
		print("none");
	}

	//// Change Image properties x=1.0, y= 1.0, z= 1.0 /////
	run("Properties...", "channels=1 slices=1 frames=1 unit=µm pixel_width=1.0 pixel_height=1.0 voxel_depth=1.0");

	waitForUser("Select area by rectangle tool or restore selection");  //wait for user action
	
	run("Plots...", "width=600 height=340 font=14 draw_ticks minimum=0 maximum=0 vertical interpolate");
	run("Plot Profile");
	Plot.getValues(x, y);
	Array.print(x);
	Array.print(y);
	//x= newArray(10, 28, 5, 67, 4, 6);
	
	//// Find minimum /////
	Vmin= 10000000000;
	for(i=0; i<lengthOf(y); i++){
		if(y[i]<Vmin){
			Vmin= y[i];
		}
	}
	
	print(Vmin);
	
	//// Find minimum /////
	Vmax= 0;
	for(i=0; i<lengthOf(y); i++){
		if(y[i]>Vmax){
			Vmax= y[i];
		}
	}
	
	print(Vmax);
	
	/// Normalize data_y /////
	for(i=0; i<lengthOf(y);i++){
		y[i]=(y[i]-Vmin)/Vmax;
	}
	
	Array.print(y);
	
	/// Normalize data_x  ////
	for(i=0; i<lengthOf(x);i++){
		x[i]=(x[i]-0)/lengthOf(x);
	}
	
	Array.print(x);
	
	
	
	
	
	
	Plot.create("Title_Red signal (normalized)", "relative position", "relative signal intensity", x, y)
	Plot.setLogScaleX(false);
	Plot.setLogScaleY(false);
	Plot.setLimits(0.000,1.000,0.000,1.000);
	Plot.setStyle(0, "Red,none,2.0,Line");
	if(bl_b== true){
		Plot.setBackgroundColor("black");
	}
}
