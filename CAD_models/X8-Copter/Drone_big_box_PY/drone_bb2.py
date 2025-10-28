# PyChrono script generated from SolidWorks using Chrono::SolidWorks add-in 
# Assembly: C:\Users\mgramuglia\Desktop\JTARV\Mattia Drone\Drone_big_box_PY\drone_bb2.SLDASM


import pychrono as chrono 
import builtins 

# some global settings: 
sphereswept_r = 0.001
chrono.ChCollisionModel.SetDefaultSuggestedEnvelope(0.003)
chrono.ChCollisionModel.SetDefaultSuggestedMargin(0.003)
chrono.ChCollisionSystemBullet.SetContactBreakingThreshold(0.002)

shapes_dir = 'drone_bb2_shapes/' 

if hasattr(builtins, 'exported_system_relpath'): 
    shapes_dir = builtins.exported_system_relpath + shapes_dir 

exported_items = [] 

body_0= chrono.ChBodyAuxRef()
body_0.SetName('ground')
body_0.SetBodyFixed(True)
exported_items.append(body_0)

# Rigid body part
body_1= chrono.ChBodyAuxRef()
body_1.SetName('box_big_200x200x100-1')
body_1.SetPos(chrono.ChVectorD(-1.31722055646533e-43,-0.225500000000002,-1.00893489431387e-43))
body_1.SetRot(chrono.ChQuaternionD(1,0,0,0))
body_1.SetMass(0.356678398800002)
body_1.SetInertiaXX(chrono.ChVectorD(0.00230806584511846,0.00384657830287282,0.00230806584511845))
body_1.SetInertiaXY(chrono.ChVectorD(5.36017556566241e-19,3.00555792072242e-19,-1.57466153292409e-18))
body_1.SetFrame_COG_to_REF(chrono.ChFrameD(chrono.ChVectorD(-1.46498601287635e-16,0.0343231818337972,1.96114607702853e-17),chrono.ChQuaternionD(1,0,0,0)))

# Visualization shape 
body_1_1_shape = chrono.ChObjFileShape() 
body_1_1_shape.SetFilename(shapes_dir +'body_1_1.obj') 
body_1.AddVisualShape(body_1_1_shape, chrono.ChFrameD(chrono.ChVectorD(0,0,0), chrono.ChQuaternionD(1,0,0,0)))

# Collision material 
mat_1 = chrono.ChMaterialSurfaceNSC()

# Collision shapes 
body_1.GetCollisionModel().ClearModel()
mr = chrono.ChMatrix33D()
mr[0,0]=-1; mr[1,0]=0; mr[2,0]=-4.62592926927152E-15 
mr[0,1]=0; mr[1,1]=0; mr[2,1]=-1 
mr[0,2]=0; mr[1,2]=-1; mr[2,2]=0 
body_1.GetCollisionModel().AddBox(mat_1, 0.00149999999999999,0.1,0.0485,chrono.ChVectorD(0.0985,0.0515,-1.38777878078145E-17),mr)
mr = chrono.ChMatrix33D()
mr[0,0]=1; mr[1,0]=0; mr[2,0]=0 
mr[0,1]=0; mr[1,1]=0; mr[2,1]=1 
mr[0,2]=0; mr[1,2]=-1; mr[2,2]=0 
body_1.GetCollisionModel().AddBox(mat_1, 0.097,0.00150000000000001,0.0485,chrono.ChVectorD(1.38777878078145E-17,0.0515,0.0985),mr)
mr = chrono.ChMatrix33D()
mr[0,0]=1; mr[1,0]=0; mr[2,0]=0 
mr[0,1]=0; mr[1,1]=0; mr[2,1]=1 
mr[0,2]=0; mr[1,2]=-1; mr[2,2]=0 
body_1.GetCollisionModel().AddBox(mat_1, 0.0015,0.1,0.0485,chrono.ChVectorD(-0.0985,0.0515,0),mr)
mr = chrono.ChMatrix33D()
mr[0,0]=0; mr[1,0]=0; mr[2,0]=1 
mr[0,1]=1; mr[1,1]=0; mr[2,1]=-6.93889390390723E-17 
mr[0,2]=0; mr[1,2]=1; mr[2,2]=0 
body_1.GetCollisionModel().AddBox(mat_1, 0.1,0.1,0.0015,chrono.ChVectorD(0,0.0015,-6.93889390390723E-18),mr)
mr = chrono.ChMatrix33D()
mr[0,0]=1; mr[1,0]=0; mr[2,0]=0 
mr[0,1]=0; mr[1,1]=0; mr[2,1]=1 
mr[0,2]=0; mr[1,2]=-1; mr[2,2]=0 
body_1.GetCollisionModel().AddBox(mat_1, 0.097,0.00149999999999999,0.0485,chrono.ChVectorD(0,0.0515,-0.0985),mr)
body_1.GetCollisionModel().BuildModel()
body_1.SetCollide(True)

exported_items.append(body_1)



# Rigid body part
body_2= chrono.ChBodyAuxRef()
body_2.SetName('3_blade_prop-3')
body_2.SetPos(chrono.ChVectorD(0.0876060135845876,0.0251400000000008,0.108591504360594))
body_2.SetRot(chrono.ChQuaternionD(0.185703476398524,0.185703476398523,-0.682286024225544,0.682286024225549))
body_2.SetMass(0.00364120675790278)
body_2.SetInertiaXX(chrono.ChVectorD(1.77944476893537e-06,2.45880871478206e-06,1.4208475579394e-06))
body_2.SetInertiaXY(chrono.ChVectorD(-6.10369871256068e-07,-2.25564711897942e-12,-1.4866390864539e-12))
body_2.SetFrame_COG_to_REF(chrono.ChFrameD(chrono.ChVectorD(-4.58230968281564e-08,-2.31695875227173e-07,-1.27309700361918e-08),chrono.ChQuaternionD(1,0,0,0)))

# Visualization shape 
body_2_1_shape = chrono.ChObjFileShape() 
body_2_1_shape.SetFilename(shapes_dir +'body_2_1.obj') 
body_2.AddVisualShape(body_2_1_shape, chrono.ChFrameD(chrono.ChVectorD(0,0,0), chrono.ChQuaternionD(1,0,0,0)))

exported_items.append(body_2)



# Rigid body part
body_3= chrono.ChBodyAuxRef()
body_3.SetName('3_blade_prop-6')
body_3.SetPos(chrono.ChVectorD(0.0881269161570884,-0.0321400000000007,-0.108345020493481))
body_3.SetRot(chrono.ChQuaternionD(0.591796151459549,-0.591796151459553,-0.38701074289697,-0.387010742896968))
body_3.SetMass(0.00364120675790278)
body_3.SetInertiaXX(chrono.ChVectorD(2.59312703521172e-06,1.64512644850571e-06,1.4208475579394e-06))
body_3.SetInertiaXY(chrono.ChVectorD(-5.13087657586407e-07,-1.20835293466856e-12,-2.41617939814297e-12))
body_3.SetFrame_COG_to_REF(chrono.ChFrameD(chrono.ChVectorD(-4.58230968281564e-08,-2.31695875227173e-07,-1.27309700361918e-08),chrono.ChQuaternionD(1,0,0,0)))

# Visualization shape 
body_2_1_shape = chrono.ChObjFileShape() 
body_2_1_shape.SetFilename(shapes_dir +'body_2_1.obj') 
body_3.AddVisualShape(body_2_1_shape, chrono.ChFrameD(chrono.ChVectorD(0,0,0), chrono.ChQuaternionD(1,0,0,0)))

exported_items.append(body_3)



# Rigid body part
body_4= chrono.ChBodyAuxRef()
body_4.SetName('3_blade_prop-2')
body_4.SetPos(chrono.ChVectorD(0.0881269161570884,0.0251399999999993,-0.108345020493481))
body_4.SetRot(chrono.ChQuaternionD(0.578192262953549,0.578192262953545,0.407054918973663,-0.407054918973666))
body_4.SetMass(0.00364120675790278)
body_4.SetInertiaXX(chrono.ChVectorD(2.65877623737073e-06,1.5794772463467e-06,1.4208475579394e-06))
body_4.SetInertiaXY(chrono.ChVectorD(-4.43524119366547e-07,7.79540211702935e-13,2.58657239548225e-12))
body_4.SetFrame_COG_to_REF(chrono.ChFrameD(chrono.ChVectorD(-4.58230968281564e-08,-2.31695875227173e-07,-1.27309700361918e-08),chrono.ChQuaternionD(1,0,0,0)))

# Visualization shape 
body_2_1_shape = chrono.ChObjFileShape() 
body_2_1_shape.SetFilename(shapes_dir +'body_2_1.obj') 
body_4.AddVisualShape(body_2_1_shape, chrono.ChFrameD(chrono.ChVectorD(0,0,0), chrono.ChQuaternionD(1,0,0,0)))

exported_items.append(body_4)



# Rigid body part
body_5= chrono.ChBodyAuxRef()
body_5.SetName('3_blade_prop-1')
body_5.SetPos(chrono.ChVectorD(-0.0876060135845876,0.0251399999999993,-0.108591504360595))
body_5.SetRot(chrono.ChQuaternionD(0.00360690136121255,0.00360690136121252,-0.707097581853146,0.707097581853151))
body_5.SetMass(0.00364120675790278)
body_5.SetInertiaXX(chrono.ChVectorD(1.4207485135268e-06,2.81750497019063e-06,1.4208475579394e-06))
body_5.SetInertiaXY(chrono.ChVectorD(-1.42503564245095e-08,-2.69638985468873e-12,-1.65895901891355e-13))
body_5.SetFrame_COG_to_REF(chrono.ChFrameD(chrono.ChVectorD(-4.58230968281564e-08,-2.31695875227173e-07,-1.27309700361918e-08),chrono.ChQuaternionD(1,0,0,0)))

# Visualization shape 
body_2_1_shape = chrono.ChObjFileShape() 
body_2_1_shape.SetFilename(shapes_dir +'body_2_1.obj') 
body_5.AddVisualShape(body_2_1_shape, chrono.ChFrameD(chrono.ChVectorD(0,0,0), chrono.ChQuaternionD(1,0,0,0)))

exported_items.append(body_5)



# Rigid body part
body_6= chrono.ChBodyAuxRef()
body_6.SetName('3_blade_prop-4')
body_6.SetPos(chrono.ChVectorD(-0.0881269161570884,0.0251400000000008,0.108345020493481))
body_6.SetRot(chrono.ChQuaternionD(-0.0536129247521179,-0.0536129247521175,-0.705071382414235,0.70507138241424))
body_6.SetMass(0.00364120675790278)
body_6.SetInertiaXX(chrono.ChVectorD(1.45254359425654e-06,2.78570988946089e-06,1.4208475579394e-06))
body_6.SetInertiaXY(chrono.ChVectorD(2.08811230059658e-07,-2.68784618149354e-12,2.71150517910646e-13))
body_6.SetFrame_COG_to_REF(chrono.ChFrameD(chrono.ChVectorD(-4.58230968281564e-08,-2.31695875227173e-07,-1.27309700361918e-08),chrono.ChQuaternionD(1,0,0,0)))

# Visualization shape 
body_2_1_shape = chrono.ChObjFileShape() 
body_2_1_shape.SetFilename(shapes_dir +'body_2_1.obj') 
body_6.AddVisualShape(body_2_1_shape, chrono.ChFrameD(chrono.ChVectorD(0,0,0), chrono.ChQuaternionD(1,0,0,0)))

exported_items.append(body_6)



# Rigid body part
body_7= chrono.ChBodyAuxRef()
body_7.SetName('3_blade_prop-5')
body_7.SetPos(chrono.ChVectorD(-0.0876060135845876,-0.0321400000000007,-0.108591504360594))
body_7.SetRot(chrono.ChQuaternionD(0.511769816668462,0.511769816668458,-0.487946364621286,0.487946364621289))
body_7.SetMass(0.00364120675790278)
body_7.SetInertiaXX(chrono.ChVectorD(2.81448064249485e-06,1.42377284122258e-06,1.4208475579394e-06))
body_7.SetInertiaXY(chrono.ChVectorD(6.6469356370884e-08,2.66734462440219e-13,-2.68828801011475e-12))
body_7.SetFrame_COG_to_REF(chrono.ChFrameD(chrono.ChVectorD(-4.58230968281564e-08,-2.31695875227173e-07,-1.27309700361918e-08),chrono.ChQuaternionD(1,0,0,0)))

# Visualization shape 
body_2_1_shape = chrono.ChObjFileShape() 
body_2_1_shape.SetFilename(shapes_dir +'body_2_1.obj') 
body_7.AddVisualShape(body_2_1_shape, chrono.ChFrameD(chrono.ChVectorD(0,0,0), chrono.ChQuaternionD(1,0,0,0)))

exported_items.append(body_7)



# Rigid body part
body_8= chrono.ChBodyAuxRef()
body_8.SetName('3_blade_prop-7')
body_8.SetPos(chrono.ChVectorD(0.0876060135845876,-0.0321399999999992,0.108591504360595))
body_8.SetRot(chrono.ChQuaternionD(0.636775854165575,-0.63677585416558,-0.307435377846629,-0.307435377846627))
body_8.SetMass(0.00364120675790278)
body_8.SetInertiaXX(chrono.ChVectorD(2.27727107318562e-06,1.96098241053181e-06,1.4208475579394e-06))
body_8.SetInertiaXY(chrono.ChVectorD(-6.80386355635834e-07,-1.78630245911343e-12,-2.02661373312675e-12))
body_8.SetFrame_COG_to_REF(chrono.ChFrameD(chrono.ChVectorD(-4.58230968281564e-08,-2.31695875227173e-07,-1.27309700361918e-08),chrono.ChQuaternionD(1,0,0,0)))

# Visualization shape 
body_2_1_shape = chrono.ChObjFileShape() 
body_2_1_shape.SetFilename(shapes_dir +'body_2_1.obj') 
body_8.AddVisualShape(body_2_1_shape, chrono.ChFrameD(chrono.ChVectorD(0,0,0), chrono.ChQuaternionD(1,0,0,0)))

exported_items.append(body_8)



# Rigid body part
body_9= chrono.ChBodyAuxRef()
body_9.SetName('3_blade_prop-8')
body_9.SetPos(chrono.ChVectorD(-0.0881269161570884,-0.0321399999999992,0.108345020493481))
body_9.SetRot(chrono.ChQuaternionD(0.60032448243821,-0.600324482438215,-0.37364490600742,-0.373644906007417))
body_9.SetMass(0.00364120675790278)
body_9.SetInertiaXX(chrono.ChVectorD(2.54526422991078e-06,1.69298925380665e-06,1.4208475579394e-06))
body_9.SetInertiaXY(chrono.ChVectorD(-5.53481764598363e-07,-1.31545625153629e-12,-2.35957931611267e-12))
body_9.SetFrame_COG_to_REF(chrono.ChFrameD(chrono.ChVectorD(-4.58230968281564e-08,-2.31695875227173e-07,-1.27309700361918e-08),chrono.ChQuaternionD(1,0,0,0)))

# Visualization shape 
body_2_1_shape = chrono.ChObjFileShape() 
body_2_1_shape.SetFilename(shapes_dir +'body_2_1.obj') 
body_9.AddVisualShape(body_2_1_shape, chrono.ChFrameD(chrono.ChVectorD(0,0,0), chrono.ChQuaternionD(1,0,0,0)))

exported_items.append(body_9)



# Rigid body part
body_10= chrono.ChBodyAuxRef()
body_10.SetName('drone_big_box-1')
body_10.SetPos(chrono.ChVectorD(0,0,0))
body_10.SetRot(chrono.ChQuaternionD(-3.49148133884313e-15,0,1,0))
body_10.SetMass(1.63968293969252)
body_10.SetInertiaXX(chrono.ChVectorD(0.0122167030253919,0.0116911012087672,0.0116160019886084))
body_10.SetInertiaXY(chrono.ChVectorD(0.000641340821426451,5.93052909440443e-06,-3.40029434725524e-06))
body_10.SetFrame_COG_to_REF(chrono.ChFrameD(chrono.ChVectorD(-0.00781920353429442,-0.0287092340719906,4.87571767365452e-05),chrono.ChQuaternionD(1,0,0,0)))

# Visualization shape 
body_10_1_shape = chrono.ChObjFileShape() 
body_10_1_shape.SetFilename(shapes_dir +'body_10_1.obj') 
body_10.AddVisualShape(body_10_1_shape, chrono.ChFrameD(chrono.ChVectorD(0,0,0), chrono.ChQuaternionD(1,0,0,0)))

# Collision material 
mat_10 = chrono.ChMaterialSurfaceNSC()

# Collision shapes 
body_10.GetCollisionModel().ClearModel()
mr = chrono.ChMatrix33D()
mr[0,0]=0; mr[1,0]=0; mr[2,0]=1 
mr[0,1]=-1; mr[1,1]=0; mr[2,1]=0
mr[0,2]=0; mr[1,2]=-1; mr[2,2]=0
body_10.GetCollisionModel().AddBox(mat_10, 0.17057502049348,0.150096464870838,0.0445,chrono.ChVectorD(-0.000260451286251212,0.00500000000000002,-2.17065816677801E-17),mr)
mr = chrono.ChMatrix33D()
mr[0,0]=1; mr[1,0]=0; mr[2,0]=0 
mr[0,1]=0; mr[1,1]=0; mr[2,1]=1 
mr[0,2]=0; mr[1,2]=-1; mr[2,2]=0 
body_10.GetCollisionModel().AddBox(mat_10, 0.1225,0.177833333333333,0.00774999999999876,chrono.ChVectorD(-2.77555756156289E-17,-0.243250000000001,0),mr)
body_10.GetCollisionModel().BuildModel()
body_10.SetCollide(True)

exported_items.append(body_10)




# Mate constraint: Concentric9 [MateConcentric] type:1 align:1 flip:False
#   Entity 0: C::E name: body_10 , SW name: drone_big_box-1 ,  SW ref.type:1 (24)
#   Entity 1: C::E name: body_5 , SW name: 3_blade_prop-1 ,  SW ref.type:1 (1)

link_1 = chrono.ChLinkMateParallel()
cA = chrono.ChVectorD(-0.0876060135845876,0.0329999999999993,-0.108591504360595)
dA = chrono.ChVectorD(-7.68410416466106e-29,1,-6.98296267768629e-15)
cB = chrono.ChVectorD(-0.0876060135845876,0.0292799999999993,-0.108591504360595)
dB = chrono.ChVectorD(7.68410416466106e-29,-1,7.10542735760102e-15)
link_1.SetFlipped(True)
link_1.Initialize(body_10,body_5,False,cA,cB,dA,dB)
link_1.SetName("Concentric9")
exported_items.append(link_1)

link_2 = chrono.ChLinkMateGeneric()
link_2.SetConstrainedCoords(False, True, True, False, False, False)
cA = chrono.ChVectorD(-0.0876060135845876,0.0329999999999993,-0.108591504360595)
cB = chrono.ChVectorD(-0.0876060135845876,0.0292799999999993,-0.108591504360595)
dA = chrono.ChVectorD(-7.68410416466106e-29,1,-6.98296267768629e-15)
dB = chrono.ChVectorD(7.68410416466106e-29,-1,7.10542735760102e-15)
link_2.Initialize(body_10,body_5,False,cA,cB,dA,dB)
link_2.SetName("Concentric9")
exported_items.append(link_2)


# Mate constraint: Coincident22 [MateCoincident] type:0 align:1 flip:False
#   Entity 0: C::E name: body_10 , SW name: drone_big_box-1 ,  SW ref.type:2 (2)
#   Entity 1: C::E name: body_5 , SW name: 3_blade_prop-1 ,  SW ref.type:2 (2)

link_3 = chrono.ChLinkMateXdistance()
cA = chrono.ChVectorD(-0.0898692425872839,0.0209999999999993,-0.107529527674714)
cB = chrono.ChVectorD(-0.0876060135845876,0.0209999999999993,-0.108591504360595)
dA = chrono.ChVectorD(-7.68410416466106e-29,1,-6.98296267768629e-15)
dB = chrono.ChVectorD(7.68410416466106e-29,-1,7.10542735760102e-15)
link_3.Initialize(body_10,body_5,False,cA,cB,dB)
link_3.SetDistance(0)
link_3.SetName("Coincident22")
exported_items.append(link_3)

link_4 = chrono.ChLinkMateParallel()
cA = chrono.ChVectorD(-0.0898692425872839,0.0209999999999993,-0.107529527674714)
dA = chrono.ChVectorD(-7.68410416466106e-29,1,-6.98296267768629e-15)
cB = chrono.ChVectorD(-0.0876060135845876,0.0209999999999993,-0.108591504360595)
dB = chrono.ChVectorD(7.68410416466106e-29,-1,7.10542735760102e-15)
link_4.SetFlipped(True)
link_4.Initialize(body_10,body_5,False,cA,cB,dA,dB)
link_4.SetName("Coincident22")
exported_items.append(link_4)


# Mate constraint: Concentric10 [MateConcentric] type:1 align:1 flip:False
#   Entity 0: C::E name: body_10 , SW name: drone_big_box-1 ,  SW ref.type:1 (24)
#   Entity 1: C::E name: body_4 , SW name: 3_blade_prop-2 ,  SW ref.type:1 (1)

link_5 = chrono.ChLinkMateParallel()
cA = chrono.ChVectorD(0.0881269161570884,0.0329999999999993,-0.108345020493481)
dA = chrono.ChVectorD(-7.68410416466106e-29,1,-6.98296267768629e-15)
cB = chrono.ChVectorD(0.0881269161570884,0.0292799999999993,-0.108345020493481)
dB = chrono.ChVectorD(7.68245751096291e-29,-1,7.10542735760102e-15)
link_5.SetFlipped(True)
link_5.Initialize(body_10,body_4,False,cA,cB,dA,dB)
link_5.SetName("Concentric10")
exported_items.append(link_5)

link_6 = chrono.ChLinkMateGeneric()
link_6.SetConstrainedCoords(False, True, True, False, False, False)
cA = chrono.ChVectorD(0.0881269161570884,0.0329999999999993,-0.108345020493481)
cB = chrono.ChVectorD(0.0881269161570884,0.0292799999999993,-0.108345020493481)
dA = chrono.ChVectorD(-7.68410416466106e-29,1,-6.98296267768629e-15)
dB = chrono.ChVectorD(7.68245751096291e-29,-1,7.10542735760102e-15)
link_6.Initialize(body_10,body_4,False,cA,cB,dA,dB)
link_6.SetName("Concentric10")
exported_items.append(link_6)


# Mate constraint: Coincident24 [MateCoincident] type:0 align:1 flip:False
#   Entity 0: C::E name: body_10 , SW name: drone_big_box-1 ,  SW ref.type:2 (2)
#   Entity 1: C::E name: body_4 , SW name: 3_blade_prop-2 ,  SW ref.type:2 (2)

link_7 = chrono.ChLinkMateXdistance()
cA = chrono.ChVectorD(0.0858706090928913,0.0209999999999993,-0.109421625542724)
cB = chrono.ChVectorD(0.0881269161570884,0.0209999999999993,-0.108345020493481)
dA = chrono.ChVectorD(-4.87617677579594e-29,1,-6.98296267768627e-15)
dB = chrono.ChVectorD(7.68245751096291e-29,-1,7.10542735760102e-15)
link_7.Initialize(body_10,body_4,False,cA,cB,dB)
link_7.SetDistance(0)
link_7.SetName("Coincident24")
exported_items.append(link_7)

link_8 = chrono.ChLinkMateParallel()
cA = chrono.ChVectorD(0.0858706090928913,0.0209999999999993,-0.109421625542724)
dA = chrono.ChVectorD(-4.87617677579594e-29,1,-6.98296267768627e-15)
cB = chrono.ChVectorD(0.0881269161570884,0.0209999999999993,-0.108345020493481)
dB = chrono.ChVectorD(7.68245751096291e-29,-1,7.10542735760102e-15)
link_8.SetFlipped(True)
link_8.Initialize(body_10,body_4,False,cA,cB,dA,dB)
link_8.SetName("Coincident24")
exported_items.append(link_8)


# Mate constraint: Concentric11 [MateConcentric] type:1 align:1 flip:False
#   Entity 0: C::E name: body_10 , SW name: drone_big_box-1 ,  SW ref.type:1 (24)
#   Entity 1: C::E name: body_2 , SW name: 3_blade_prop-3 ,  SW ref.type:1 (1)

link_9 = chrono.ChLinkMateParallel()
cA = chrono.ChVectorD(0.0876060135845876,0.0330000000000008,0.108591504360594)
dA = chrono.ChVectorD(-7.68410416466106e-29,1,-6.98296267768629e-15)
cB = chrono.ChVectorD(0.0876060135845876,0.0292800000000008,0.108591504360594)
dB = chrono.ChVectorD(7.68410416466105e-29,-1,7.10542735760102e-15)
link_9.SetFlipped(True)
link_9.Initialize(body_10,body_2,False,cA,cB,dA,dB)
link_9.SetName("Concentric11")
exported_items.append(link_9)

link_10 = chrono.ChLinkMateGeneric()
link_10.SetConstrainedCoords(False, True, True, False, False, False)
cA = chrono.ChVectorD(0.0876060135845876,0.0330000000000008,0.108591504360594)
cB = chrono.ChVectorD(0.0876060135845876,0.0292800000000008,0.108591504360594)
dA = chrono.ChVectorD(-7.68410416466106e-29,1,-6.98296267768629e-15)
dB = chrono.ChVectorD(7.68410416466105e-29,-1,7.10542735760102e-15)
link_10.Initialize(body_10,body_2,False,cA,cB,dA,dB)
link_10.SetName("Concentric11")
exported_items.append(link_10)


# Mate constraint: Coincident26 [MateCoincident] type:0 align:1 flip:False
#   Entity 0: C::E name: body_10 , SW name: drone_big_box-1 ,  SW ref.type:2 (2)
#   Entity 1: C::E name: body_2 , SW name: 3_blade_prop-3 ,  SW ref.type:2 (2)

link_11 = chrono.ChLinkMateXdistance()
cA = chrono.ChVectorD(0.0853427845818912,0.0210000000000008,0.109653481046475)
cB = chrono.ChVectorD(0.0876060135845876,0.0210000000000008,0.108591504360594)
dA = chrono.ChVectorD(-4.87617677579594e-29,1,-6.98296267768627e-15)
dB = chrono.ChVectorD(7.68410416466105e-29,-1,7.10542735760102e-15)
link_11.Initialize(body_10,body_2,False,cA,cB,dB)
link_11.SetDistance(0)
link_11.SetName("Coincident26")
exported_items.append(link_11)

link_12 = chrono.ChLinkMateParallel()
cA = chrono.ChVectorD(0.0853427845818912,0.0210000000000008,0.109653481046475)
dA = chrono.ChVectorD(-4.87617677579594e-29,1,-6.98296267768627e-15)
cB = chrono.ChVectorD(0.0876060135845876,0.0210000000000008,0.108591504360594)
dB = chrono.ChVectorD(7.68410416466105e-29,-1,7.10542735760102e-15)
link_12.SetFlipped(True)
link_12.Initialize(body_10,body_2,False,cA,cB,dA,dB)
link_12.SetName("Coincident26")
exported_items.append(link_12)


# Mate constraint: Concentric12 [MateConcentric] type:1 align:1 flip:False
#   Entity 0: C::E name: body_10 , SW name: drone_big_box-1 ,  SW ref.type:1 (24)
#   Entity 1: C::E name: body_6 , SW name: 3_blade_prop-4 ,  SW ref.type:1 (1)

link_13 = chrono.ChLinkMateParallel()
cA = chrono.ChVectorD(-0.0881269161570884,0.0330000000000008,0.108345020493481)
dA = chrono.ChVectorD(-7.68410416466106e-29,1,-6.98296267768629e-15)
cB = chrono.ChVectorD(-0.0881269161570884,0.0292800000000008,0.108345020493481)
dB = chrono.ChVectorD(7.68410416466106e-29,-1,7.10542735760102e-15)
link_13.SetFlipped(True)
link_13.Initialize(body_10,body_6,False,cA,cB,dA,dB)
link_13.SetName("Concentric12")
exported_items.append(link_13)

link_14 = chrono.ChLinkMateGeneric()
link_14.SetConstrainedCoords(False, True, True, False, False, False)
cA = chrono.ChVectorD(-0.0881269161570884,0.0330000000000008,0.108345020493481)
cB = chrono.ChVectorD(-0.0881269161570884,0.0292800000000008,0.108345020493481)
dA = chrono.ChVectorD(-7.68410416466106e-29,1,-6.98296267768629e-15)
dB = chrono.ChVectorD(7.68410416466106e-29,-1,7.10542735760102e-15)
link_14.Initialize(body_10,body_6,False,cA,cB,dA,dB)
link_14.SetName("Concentric12")
exported_items.append(link_14)


# Mate constraint: Coincident28 [MateCoincident] type:0 align:1 flip:False
#   Entity 0: C::E name: body_10 , SW name: drone_big_box-1 ,  SW ref.type:2 (2)
#   Entity 1: C::E name: body_6 , SW name: 3_blade_prop-4 ,  SW ref.type:2 (2)

link_15 = chrono.ChLinkMateXdistance()
cA = chrono.ChVectorD(-0.0903832232212855,0.0210000000000008,0.107268415444238)
cB = chrono.ChVectorD(-0.0881269161570884,0.0210000000000008,0.108345020493481)
dA = chrono.ChVectorD(-4.87617677579594e-29,1,-6.98296267768627e-15)
dB = chrono.ChVectorD(7.68410416466106e-29,-1,7.10542735760102e-15)
link_15.Initialize(body_10,body_6,False,cA,cB,dB)
link_15.SetDistance(0)
link_15.SetName("Coincident28")
exported_items.append(link_15)

link_16 = chrono.ChLinkMateParallel()
cA = chrono.ChVectorD(-0.0903832232212855,0.0210000000000008,0.107268415444238)
dA = chrono.ChVectorD(-4.87617677579594e-29,1,-6.98296267768627e-15)
cB = chrono.ChVectorD(-0.0881269161570884,0.0210000000000008,0.108345020493481)
dB = chrono.ChVectorD(7.68410416466106e-29,-1,7.10542735760102e-15)
link_16.SetFlipped(True)
link_16.Initialize(body_10,body_6,False,cA,cB,dA,dB)
link_16.SetName("Coincident28")
exported_items.append(link_16)


# Mate constraint: Coincident29 [MateCoincident] type:0 align:1 flip:False
#   Entity 0: C::E name: body_10 , SW name: drone_big_box-1 ,  SW ref.type:2 (2)
#   Entity 1: C::E name: body_1 , SW name: box_big_200x200x100-1 ,  SW ref.type:2 (2)

link_17 = chrono.ChLinkMateXdistance()
cA = chrono.ChVectorD(-0.0949999999999987,-0.225500000000002,0.179999999999999)
cB = chrono.ChVectorD(-1.31722055646533e-43,-0.225500000000002,-1.00893489431387e-43)
dA = chrono.ChVectorD(0,1,0)
dB = chrono.ChVectorD(0,-1,0)
link_17.Initialize(body_10,body_1,False,cA,cB,dB)
link_17.SetDistance(0)
link_17.SetName("Coincident29")
exported_items.append(link_17)

link_18 = chrono.ChLinkMateParallel()
cA = chrono.ChVectorD(-0.0949999999999987,-0.225500000000002,0.179999999999999)
dA = chrono.ChVectorD(0,1,0)
cB = chrono.ChVectorD(-1.31722055646533e-43,-0.225500000000002,-1.00893489431387e-43)
dB = chrono.ChVectorD(0,-1,0)
link_18.SetFlipped(True)
link_18.Initialize(body_10,body_1,False,cA,cB,dA,dB)
link_18.SetName("Coincident29")
exported_items.append(link_18)


# Mate constraint: Coincident30 [MateCoincident] type:0 align:1 flip:False
#   Entity 0: C::E name: body_10 , SW name: drone_big_box-1 ,  SW ref.type:4 (4)
#   Entity 1: C::E name: body_1 , SW name: box_big_200x200x100-1 ,  SW ref.type:4 (4)

link_19 = chrono.ChLinkMateXdistance()
cA = chrono.ChVectorD(0,0,0)
cB = chrono.ChVectorD(-1.31722055646533e-43,-0.225500000000002,-1.00893489431387e-43)
dA = chrono.ChVectorD(-6.98296267768627e-15,0,-1)
dB = chrono.ChVectorD(0,0,1)
link_19.Initialize(body_10,body_1,False,cA,cB,dB)
link_19.SetDistance(0)
link_19.SetName("Coincident30")
exported_items.append(link_19)

link_20 = chrono.ChLinkMateParallel()
cA = chrono.ChVectorD(0,0,0)
dA = chrono.ChVectorD(-6.98296267768627e-15,0,-1)
cB = chrono.ChVectorD(-1.31722055646533e-43,-0.225500000000002,-1.00893489431387e-43)
dB = chrono.ChVectorD(0,0,1)
link_20.SetFlipped(True)
link_20.Initialize(body_10,body_1,False,cA,cB,dA,dB)
link_20.SetName("Coincident30")
exported_items.append(link_20)


# Mate constraint: Coincident31 [MateCoincident] type:0 align:1 flip:False
#   Entity 0: C::E name: body_10 , SW name: drone_big_box-1 ,  SW ref.type:4 (4)
#   Entity 1: C::E name: body_1 , SW name: box_big_200x200x100-1 ,  SW ref.type:4 (4)

link_21 = chrono.ChLinkMateXdistance()
cA = chrono.ChVectorD(0,0,0)
cB = chrono.ChVectorD(-1.31722055646533e-43,-0.225500000000002,-1.00893489431387e-43)
dA = chrono.ChVectorD(-1,0,6.98296267768627e-15)
dB = chrono.ChVectorD(1,0,0)
link_21.Initialize(body_10,body_1,False,cA,cB,dB)
link_21.SetDistance(0)
link_21.SetName("Coincident31")
exported_items.append(link_21)

link_22 = chrono.ChLinkMateParallel()
cA = chrono.ChVectorD(0,0,0)
dA = chrono.ChVectorD(-1,0,6.98296267768627e-15)
cB = chrono.ChVectorD(-1.31722055646533e-43,-0.225500000000002,-1.00893489431387e-43)
dB = chrono.ChVectorD(1,0,0)
link_22.SetFlipped(True)
link_22.Initialize(body_10,body_1,False,cA,cB,dA,dB)
link_22.SetName("Coincident31")
exported_items.append(link_22)


# Mate constraint: Concentric13 [MateConcentric] type:1 align:1 flip:False
#   Entity 0: C::E name: body_10 , SW name: drone_big_box-1 ,  SW ref.type:1 (1)
#   Entity 1: C::E name: body_7 , SW name: 3_blade_prop-5 ,  SW ref.type:1 (1)

link_23 = chrono.ChLinkMateParallel()
cA = chrono.ChVectorD(-0.0876060135845876,-0.0400000000000007,-0.108591504360594)
dA = chrono.ChVectorD(-7.68410416466106e-29,1,-6.98296267768629e-15)
cB = chrono.ChVectorD(-0.0876060135845876,-0.0362800000000007,-0.108591504360594)
dB = chrono.ChVectorD(7.68410416466106e-29,-1,7.22789203751576e-15)
link_23.SetFlipped(True)
link_23.Initialize(body_10,body_7,False,cA,cB,dA,dB)
link_23.SetName("Concentric13")
exported_items.append(link_23)

link_24 = chrono.ChLinkMateGeneric()
link_24.SetConstrainedCoords(False, True, True, False, False, False)
cA = chrono.ChVectorD(-0.0876060135845876,-0.0400000000000007,-0.108591504360594)
cB = chrono.ChVectorD(-0.0876060135845876,-0.0362800000000007,-0.108591504360594)
dA = chrono.ChVectorD(-7.68410416466106e-29,1,-6.98296267768629e-15)
dB = chrono.ChVectorD(7.68410416466106e-29,-1,7.22789203751576e-15)
link_24.Initialize(body_10,body_7,False,cA,cB,dA,dB)
link_24.SetName("Concentric13")
exported_items.append(link_24)


# Mate constraint: Coincident33 [MateCoincident] type:0 align:1 flip:False
#   Entity 0: C::E name: body_10 , SW name: drone_big_box-1 ,  SW ref.type:2 (2)
#   Entity 1: C::E name: body_7 , SW name: 3_blade_prop-5 ,  SW ref.type:2 (2)

link_25 = chrono.ChLinkMateXdistance()
cA = chrono.ChVectorD(-0.0865440368987069,-0.0280000000000007,-0.106328275357898)
cB = chrono.ChVectorD(-0.0876060135845876,-0.0280000000000007,-0.108591504360594)
dA = chrono.ChVectorD(7.68410416466106e-29,-1,6.98296267768629e-15)
dB = chrono.ChVectorD(-7.68410416466106e-29,1,-7.22789203751576e-15)
link_25.Initialize(body_10,body_7,False,cA,cB,dB)
link_25.SetDistance(0)
link_25.SetName("Coincident33")
exported_items.append(link_25)

link_26 = chrono.ChLinkMateParallel()
cA = chrono.ChVectorD(-0.0865440368987069,-0.0280000000000007,-0.106328275357898)
dA = chrono.ChVectorD(7.68410416466106e-29,-1,6.98296267768629e-15)
cB = chrono.ChVectorD(-0.0876060135845876,-0.0280000000000007,-0.108591504360594)
dB = chrono.ChVectorD(-7.68410416466106e-29,1,-7.22789203751576e-15)
link_26.SetFlipped(True)
link_26.Initialize(body_10,body_7,False,cA,cB,dA,dB)
link_26.SetName("Coincident33")
exported_items.append(link_26)


# Mate constraint: Concentric14 [MateConcentric] type:1 align:1 flip:False
#   Entity 0: C::E name: body_10 , SW name: drone_big_box-1 ,  SW ref.type:1 (24)
#   Entity 1: C::E name: body_3 , SW name: 3_blade_prop-6 ,  SW ref.type:1 (1)

link_27 = chrono.ChLinkMateParallel()
cA = chrono.ChVectorD(0.0881269161570884,-0.0400000000000007,-0.108345020493481)
dA = chrono.ChVectorD(7.68410416466106e-29,-1,6.98296267768629e-15)
cB = chrono.ChVectorD(0.0881269161570884,-0.0280000000000007,-0.108345020493481)
dB = chrono.ChVectorD(-7.68410416466107e-29,1,-7.10542735760102e-15)
link_27.SetFlipped(True)
link_27.Initialize(body_10,body_3,False,cA,cB,dA,dB)
link_27.SetName("Concentric14")
exported_items.append(link_27)

link_28 = chrono.ChLinkMateGeneric()
link_28.SetConstrainedCoords(False, True, True, False, False, False)
cA = chrono.ChVectorD(0.0881269161570884,-0.0400000000000007,-0.108345020493481)
cB = chrono.ChVectorD(0.0881269161570884,-0.0280000000000007,-0.108345020493481)
dA = chrono.ChVectorD(7.68410416466106e-29,-1,6.98296267768629e-15)
dB = chrono.ChVectorD(-7.68410416466107e-29,1,-7.10542735760102e-15)
link_28.Initialize(body_10,body_3,False,cA,cB,dA,dB)
link_28.SetName("Concentric14")
exported_items.append(link_28)


# Mate constraint: Coincident35 [MateCoincident] type:0 align:1 flip:False
#   Entity 0: C::E name: body_10 , SW name: drone_big_box-1 ,  SW ref.type:2 (2)
#   Entity 1: C::E name: body_3 , SW name: 3_blade_prop-6 ,  SW ref.type:2 (2)

link_29 = chrono.ChLinkMateXdistance()
cA = chrono.ChVectorD(0.0870503111078459,-0.0280000000000007,-0.106088713429284)
cB = chrono.ChVectorD(0.0881269161570884,-0.0280000000000007,-0.108345020493481)
dA = chrono.ChVectorD(4.87617677579594e-29,-1,6.98296267768627e-15)
dB = chrono.ChVectorD(-7.68410416466107e-29,1,-7.10542735760102e-15)
link_29.Initialize(body_10,body_3,False,cA,cB,dB)
link_29.SetDistance(0)
link_29.SetName("Coincident35")
exported_items.append(link_29)

link_30 = chrono.ChLinkMateParallel()
cA = chrono.ChVectorD(0.0870503111078459,-0.0280000000000007,-0.106088713429284)
dA = chrono.ChVectorD(4.87617677579594e-29,-1,6.98296267768627e-15)
cB = chrono.ChVectorD(0.0881269161570884,-0.0280000000000007,-0.108345020493481)
dB = chrono.ChVectorD(-7.68410416466107e-29,1,-7.10542735760102e-15)
link_30.SetFlipped(True)
link_30.Initialize(body_10,body_3,False,cA,cB,dA,dB)
link_30.SetName("Coincident35")
exported_items.append(link_30)


# Mate constraint: Concentric15 [MateConcentric] type:1 align:1 flip:False
#   Entity 0: C::E name: body_10 , SW name: drone_big_box-1 ,  SW ref.type:1 (24)
#   Entity 1: C::E name: body_8 , SW name: 3_blade_prop-7 ,  SW ref.type:1 (1)

link_31 = chrono.ChLinkMateParallel()
cA = chrono.ChVectorD(0.0876060135845876,-0.0399999999999992,0.108591504360595)
dA = chrono.ChVectorD(7.68410416466106e-29,-1,6.98296267768629e-15)
cB = chrono.ChVectorD(0.0876060135845876,-0.0279999999999992,0.108591504360595)
dB = chrono.ChVectorD(-7.68410416466107e-29,1,-7.10542735760102e-15)
link_31.SetFlipped(True)
link_31.Initialize(body_10,body_8,False,cA,cB,dA,dB)
link_31.SetName("Concentric15")
exported_items.append(link_31)

link_32 = chrono.ChLinkMateGeneric()
link_32.SetConstrainedCoords(False, True, True, False, False, False)
cA = chrono.ChVectorD(0.0876060135845876,-0.0399999999999992,0.108591504360595)
cB = chrono.ChVectorD(0.0876060135845876,-0.0279999999999992,0.108591504360595)
dA = chrono.ChVectorD(7.68410416466106e-29,-1,6.98296267768629e-15)
dB = chrono.ChVectorD(-7.68410416466107e-29,1,-7.10542735760102e-15)
link_32.Initialize(body_10,body_8,False,cA,cB,dA,dB)
link_32.SetName("Concentric15")
exported_items.append(link_32)


# Mate constraint: Coincident37 [MateCoincident] type:0 align:1 flip:False
#   Entity 0: C::E name: body_10 , SW name: drone_big_box-1 ,  SW ref.type:2 (2)
#   Entity 1: C::E name: body_8 , SW name: 3_blade_prop-7 ,  SW ref.type:2 (2)

link_33 = chrono.ChLinkMateXdistance()
cA = chrono.ChVectorD(0.0886679902704682,-0.0279999999999992,0.110854733363291)
cB = chrono.ChVectorD(0.0876060135845876,-0.0279999999999992,0.108591504360595)
dA = chrono.ChVectorD(4.87617677579594e-29,-1,6.98296267768627e-15)
dB = chrono.ChVectorD(-7.68410416466107e-29,1,-7.10542735760102e-15)
link_33.Initialize(body_10,body_8,False,cA,cB,dB)
link_33.SetDistance(0)
link_33.SetName("Coincident37")
exported_items.append(link_33)

link_34 = chrono.ChLinkMateParallel()
cA = chrono.ChVectorD(0.0886679902704682,-0.0279999999999992,0.110854733363291)
dA = chrono.ChVectorD(4.87617677579594e-29,-1,6.98296267768627e-15)
cB = chrono.ChVectorD(0.0876060135845876,-0.0279999999999992,0.108591504360595)
dB = chrono.ChVectorD(-7.68410416466107e-29,1,-7.10542735760102e-15)
link_34.SetFlipped(True)
link_34.Initialize(body_10,body_8,False,cA,cB,dA,dB)
link_34.SetName("Coincident37")
exported_items.append(link_34)


# Mate constraint: Concentric16 [MateConcentric] type:1 align:1 flip:False
#   Entity 0: C::E name: body_10 , SW name: drone_big_box-1 ,  SW ref.type:1 (24)
#   Entity 1: C::E name: body_9 , SW name: 3_blade_prop-8 ,  SW ref.type:1 (1)

link_35 = chrono.ChLinkMateParallel()
cA = chrono.ChVectorD(-0.0881269161570884,-0.0399999999999992,0.108345020493481)
dA = chrono.ChVectorD(7.68410416466106e-29,-1,6.98296267768629e-15)
cB = chrono.ChVectorD(-0.0881269161570884,-0.0362799999999992,0.108345020493481)
dB = chrono.ChVectorD(-7.68410416466106e-29,1,-7.10542735760102e-15)
link_35.SetFlipped(True)
link_35.Initialize(body_10,body_9,False,cA,cB,dA,dB)
link_35.SetName("Concentric16")
exported_items.append(link_35)

link_36 = chrono.ChLinkMateGeneric()
link_36.SetConstrainedCoords(False, True, True, False, False, False)
cA = chrono.ChVectorD(-0.0881269161570884,-0.0399999999999992,0.108345020493481)
cB = chrono.ChVectorD(-0.0881269161570884,-0.0362799999999992,0.108345020493481)
dA = chrono.ChVectorD(7.68410416466106e-29,-1,6.98296267768629e-15)
dB = chrono.ChVectorD(-7.68410416466106e-29,1,-7.10542735760102e-15)
link_36.Initialize(body_10,body_9,False,cA,cB,dA,dB)
link_36.SetName("Concentric16")
exported_items.append(link_36)


# Mate constraint: Coincident39 [MateCoincident] type:0 align:1 flip:False
#   Entity 0: C::E name: body_10 , SW name: drone_big_box-1 ,  SW ref.type:2 (2)
#   Entity 1: C::E name: body_9 , SW name: 3_blade_prop-8 ,  SW ref.type:2 (2)

link_37 = chrono.ChLinkMateXdistance()
cA = chrono.ChVectorD(-0.0892035212063309,-0.0279999999999992,0.110601327557678)
cB = chrono.ChVectorD(-0.0881269161570884,-0.0279999999999992,0.108345020493481)
dA = chrono.ChVectorD(4.87617677579594e-29,-1,6.98296267768627e-15)
dB = chrono.ChVectorD(-7.68410416466106e-29,1,-7.10542735760102e-15)
link_37.Initialize(body_10,body_9,False,cA,cB,dB)
link_37.SetDistance(0)
link_37.SetName("Coincident39")
exported_items.append(link_37)

link_38 = chrono.ChLinkMateParallel()
cA = chrono.ChVectorD(-0.0892035212063309,-0.0279999999999992,0.110601327557678)
dA = chrono.ChVectorD(4.87617677579594e-29,-1,6.98296267768627e-15)
cB = chrono.ChVectorD(-0.0881269161570884,-0.0279999999999992,0.108345020493481)
dB = chrono.ChVectorD(-7.68410416466106e-29,1,-7.10542735760102e-15)
link_38.SetFlipped(True)
link_38.Initialize(body_10,body_9,False,cA,cB,dA,dB)
link_38.SetName("Coincident39")
exported_items.append(link_38)


# Auxiliary marker (coordinate system feature)
marker_0_1 =chrono.ChMarker()
marker_0_1.SetName('Coordinate System1')
body_0.AddMarker(marker_0_1)
marker_0_1.Impose_Abs_Coord(chrono.ChCoordsysD(chrono.ChVectorD(-0.0876060135845876,0.0329999999999993,-0.108591504360595),chrono.ChQuaternionD(0.707106781186545,-0.70710678118655,-1.73657615779838E-29,1.73657615779839E-29)))

# Auxiliary marker (coordinate system feature)
marker_0_2 =chrono.ChMarker()
marker_0_2.SetName('Coordinate System2')
body_0.AddMarker(marker_0_2)
marker_0_2.Impose_Abs_Coord(chrono.ChCoordsysD(chrono.ChVectorD(0.0881269161570884,0.0329999999999993,-0.108345020493481),chrono.ChQuaternionD(0.707106781186545,-0.70710678118655,-1.73657615779838E-29,1.73657615779839E-29)))

# Auxiliary marker (coordinate system feature)
marker_0_3 =chrono.ChMarker()
marker_0_3.SetName('Coordinate System3')
body_0.AddMarker(marker_0_3)
marker_0_3.Impose_Abs_Coord(chrono.ChCoordsysD(chrono.ChVectorD(0.0876060135845876,0.0330000000000008,0.108591504360594),chrono.ChQuaternionD(0.707106781186545,-0.70710678118655,-1.73657615779838E-29,1.73657615779839E-29)))

# Auxiliary marker (coordinate system feature)
marker_0_4 =chrono.ChMarker()
marker_0_4.SetName('Coordinate System4')
body_0.AddMarker(marker_0_4)
marker_0_4.Impose_Abs_Coord(chrono.ChCoordsysD(chrono.ChVectorD(-0.0881269161570884,0.0330000000000008,0.108345020493481),chrono.ChQuaternionD(0.707106781186545,-0.70710678118655,-1.73657615779838E-29,1.73657615779839E-29)))

# Auxiliary marker (coordinate system feature)
marker_0_5 =chrono.ChMarker()
marker_0_5.SetName('Coordinate System5')
body_0.AddMarker(marker_0_5)
marker_0_5.Impose_Abs_Coord(chrono.ChCoordsysD(chrono.ChVectorD(-0.0876060135845876,-0.0400000000000007,-0.108591504360594),chrono.ChQuaternionD(0.707106781186545,-0.70710678118655,-1.73657615779838E-29,1.73657615779839E-29)))

# Auxiliary marker (coordinate system feature)
marker_0_6 =chrono.ChMarker()
marker_0_6.SetName('Coordinate System6')
body_0.AddMarker(marker_0_6)
marker_0_6.Impose_Abs_Coord(chrono.ChCoordsysD(chrono.ChVectorD(0.0881269161570884,-0.0400000000000007,-0.108345020493481),chrono.ChQuaternionD(0.707106781186545,-0.70710678118655,-1.73657615779838E-29,1.73657615779839E-29)))

# Auxiliary marker (coordinate system feature)
marker_0_7 =chrono.ChMarker()
marker_0_7.SetName('Coordinate System7')
body_0.AddMarker(marker_0_7)
marker_0_7.Impose_Abs_Coord(chrono.ChCoordsysD(chrono.ChVectorD(0.0876060135845876,-0.0399999999999992,0.108591504360595),chrono.ChQuaternionD(0.707106781186545,-0.70710678118655,-1.73657615779838E-29,1.73657615779839E-29)))

# Auxiliary marker (coordinate system feature)
marker_0_8 =chrono.ChMarker()
marker_0_8.SetName('Coordinate System8')
body_0.AddMarker(marker_0_8)
marker_0_8.Impose_Abs_Coord(chrono.ChCoordsysD(chrono.ChVectorD(-0.0881269161570884,-0.0399999999999992,0.108345020493481),chrono.ChQuaternionD(0.707106781186545,-0.70710678118655,-1.73657615779838E-29,1.73657615779839E-29)))
