#define _Vc_ -150
#define _Voper1_ -129
#define _Voper2_ -125.39
#define _Vwcathode_ -99
#define _Vwpad_ 100
#define _Vwanode_ 1
#define _QC_ 
#define _Tmodel_ 
#define _DF_ GradQuasiFermi
#define _EQ_ Poisson Electron Hole 
#define _devEQ_ lgad.Poisson lgad.Electron lgad.Hole lgad.Contact circuit 
#define _Imax_ 1e-8
#define _temp_ 253.15
#define _pad_ @pad@
#if @pad@ == 0
#define _finaltime_ 15e-9
#else
#define _finaltime_ 5e-9
#endif

File {
	Grid = "@tdr@"
	Plot = "@tdrdat@"
	Current = "@plot@"
	Output = "@log@"
	param = "@parameter@"
#	param = "models.par"
	ACExtract = "@acplot@"
}

Device LGAD {
	Electrode {
		{ Name="Anode_left" Voltage= 0.0 }
		{ Name="Anode_right" Voltage= 0.0 }
		{ Name="pad_1" Voltage= 0.0 }
		{ Name="pad_2" Voltage= 0.0 }
		{ Name="pad_3" Voltage= 0.0 }
		{ Name="Cathode" Voltage= 0.0 }
		{ Name="gr_left" Voltage= 0.0 }
		{ Name="gr_right" Voltage= 0.0 }
	}
#	Thermode {
#		{ Name="Anode_left" Temperature=253.15 }
#		{ Name="Anode_right" Temperature=253.15 }
#		{ Name="pad_1" Temperature=253.15 }
#		{ Name="pad_2" Temperature=253.15 }
#		{ Name="pad_3" Temperature=253.15 }
#		{ Name="Cathode" Temperature=253.15 }
#		{ Name="gr_left" Temperature=253.15 }
#		{ Name="gr_right" Temperature=253.15 }
#	 }
}

System {
#if @heavyion@ == 0
	Vsource_pset v0 (n@pad@ gnd_gr) {
		pwl = (
					0.0e+00 0.0
					2.0e-12 0.5
					4.0e-12 1.0
				)
	}
#endif
	LGAD lgad ("Anode_left" = n0 "Anode_right" = n0 "Cathode" = cathode "pad_1" = n1 
						 "pad_2" = n2 "pad_3" = n3 "gr_left" = gnd_gr "gr_right" = gnd_gr)

# nodes where pwl is applied should be commented except for gnd

#if @pad@ != 0
	Set (n0 = 0)
#endif
#if @pad@ !=1
	Set (n1 = 0)
#endif
#if @pad@ !=2
	Set (n2 = 0)
#endif
#if @pad@ !=3
	Set (n3 = 0)
#endif

#if @heavyion@ == 1
	Set (n0 = 0)
#endif

	Set (gnd_gr = 0)
	Set (cathode = 0)

#	Plot "nodes.plt" (time() gnd n@pad@)

}


Physics {
	Temperature=293.15
	_QC_
	_Tmodel_
#	Thermodynamic
	AreaFactor=1
#	AreaFactor=1300
	Fermi
	Mobility(
		DopingDependence
#		eHighFieldSaturation (_DF_)
#		hHighFieldSaturation (GradQuasiFermi)
		HighFieldSaturation(GradQuasiFermi)
		Enormal
		)
	Recombination(
		SRH( DopingDep )	
#		eAvalanche (_DF_)
		Auger(WithGeneration)
		Avalanche(ElectricField	okuto	)
#		Avalanche(BandgapDependence ElectricField okuto)
#		Avalanche(BandgapDependence ElectricField UniBo2)
#		Avalanche(ElectricField unibo)
#		Avalanche(ElectricField Okuto)
		Band2Band(E2)
		)
	EffectiveIntrinsicDensity(OldSlotboom)
#if @heavyion@ == 1
	HeavyIon(
		Direction=(1,0)
#		Location=(0,623.75)
		Location=(0,273.75)
		Time=1e-10
		Length=50.0
		LET_f=120e-7
		Wt_hi=0.05
#		Wt_hi=0.1
#		Wt_hi=5
		Gaussian
		PicoCoulomb
	)
#endif

}

CurrentPlot {
  AvalancheGeneration(Integrate(Semiconductor))
}

Plot {
	Potential
	ElectricField/Vector
	eDensity hDensity
	eMobility hMobility
	eCurrent/Vector hCurrent/Vector TotalCurrent/Vector
	Doping DonorConcentration AcceptorConcentration
	eTemperature hTemperature Temperature
	eAvalancheGeneration hAvalancheGeneration AvalancheGeneration
	HeavyIonChargeDensity
	eIonIntegral hIonIntegral MeanIonIntegral eAlphaAvalanche hAlphaAvalanche
	SRH Band2Band * Auger
}

Math {
	ImplicitACSystem
#	NoSRHperPotential
	NumberOfThreads= maximum
	Extrapolate
	digits= 8
	Notdamped= 100
	Iterations= 30
	RelErrControl
	Method= Blocked
	SubMethod= Pardiso
	Transient= BE
	ErRef(Electron)=1e10
	ErRef(Hole)=1e10
	CurrentWeighting
#	AvalPostProcessing
#	BreakCriteria{Current(Contact= "Anode_left" AbsVal= _Imax_)}
	ComputeIonizationIntegrals
#	BreakAtIonIntegral(3 1.1)
#	BreakCriteria{Current(Contact= "Cathode" AbsVal= _Imax_)}
}

Solve {
	NewCurrentPrefix= "init_"
	Coupled(Iterations=200){ Poisson _QC_ }
	Coupled{ _EQ_ _QC_}
#	NewCurrentPrefix= "temp_ramp_"
#	Quasistationary(
#		InitialStep= 1e-3 MinStep= 1e-7 MaxStep= 0.05 Increment= 1.41
#		Goal{ Model="DeviceTemperature" Parameter="Temperature" Value=_temp_ }
#	)
#	{ Coupled { _devEQ_ _QC_}
#		Plot (FilePrefix="temp_ramp_@node@" Time=(1.0) NoOverwrite)
#		}
	NewCurrentPrefix= "IV_"
	Quasistationary(
		InitialStep= 1e-7 MinStep= 1e-10 MaxStep= 0.01 Increment= 1.41
#		Goal{ Node="cathode" Voltage= _Vc_ }
		Goal{ Node="cathode" Voltage= _Voper1_ }
	)
	{ Coupled { _devEQ_ _QC_}
		Plot (FilePrefix="normal_bias_@node@" Time=(1.0) NoOverwrite)
		}

#if @heavyion@ == 0

	NewCurrentPrefix= "transramp_"
	Transient(
		InitialTime=0
		FinalTime=_finaltime_
		InitialStep=1e-14
		MaxStep=1e-10
		MinStep=1e-15
	) { Coupled { _devEQ_ } 
		 Plot (
				FilePreFix="dynamic_n@node@"
				Time = (range=(4e-12 _finaltime_) intervals=50 decade)
				NoOverwrite
				) }

#endif

#if @heavyion@ == 1
	NewCurrentPrefix= "transient_"
	Transient(
		InitialTime=0 FinalTime=5e-9
		InitialStep= 1e-12 Increment=1.41
		MinStep= 1e-13 MaxStep= 2e-11
	){ Coupled { _devEQ_ _QC_ }
	}

#endif

		 System("rm init_lgad_LGAD_n@node@_des.plt")
}
