#define _Vc_ -500
#define _Voper_ -100
#define _QC_ 
#define _Tmodel_ 
#define _DF_ GradQuasiFermi
#define _EQ_ Poisson Electron Hole
#define _Imax_ 1e-5
#define _position_ @<650 + position * 35>@

File {
	Grid = "@tdr@"
	Plot = "@tdrdat@"
	Current = "@plot@"
	Output = "@log@"
	param = "@parameter@"
#	param = "models.par"
	ACExtract = "@acplot@"
}

Electrode {
#if "@type@" == "ac"
	{ Name="anode" Voltage= 0.0 }
	{ Name="pad_1" Voltage= 0.0 }
	{ Name="pad_2" Voltage= 0.0 }
	{ Name="pad_3" Voltage= 0.0 }
	{ Name="pad_4" Voltage= 0.0 }
	{ Name="pad_5" Voltage= 0.0 }
	{ Name="pad_6" Voltage= 0.0 }
	{ Name="pad_7" Voltage= 0.0 }
	{ Name="pad_8" Voltage= 0.0 }
	{ Name="pad_9" Voltage= 0.0 }
#endif
	{ Name="cathode" Voltage= 0.0 }
	{ Name="gr" Voltage= 0.0 }
}
#if "@type@" == "ac"
Thermode {
	{ Name="anode" Temperature=300 }
	{ Name="pad_1" Temperature=300 }
	{ Name="pad_2" Temperature=300 }
	{ Name="pad_3" Temperature=300 }
	{ Name="pad_4" Temperature=300 }
	{ Name="pad_5" Temperature=300 }
	{ Name="pad_6" Temperature=300 }
	{ Name="pad_7" Temperature=300 }
	{ Name="pad_8" Temperature=300 }
	{ Name="pad_9" Temperature=300 }
	{ Name="cathode" Temperature=300 }
	{ Name="gr" Temperature=300 }
 }
#else
Thermode {
	{ Name="Anode" Temperature=300 }
	{ Name="Cathode" Temperature=300 }
	{ Name="gr_left" Temperature=300 }
	{ Name="gr_right" Temperature=300 }
}
#endif

Physics {
	_QC_
	_Tmodel_
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
		Avalanche(Eparallel)
		Band2Band(E2)
		)
	EffectiveIntrinsicDensity(OldSlotboom)
#if @heavyion@ == 1
	HeavyIon(
		Direction=(1,0)
#		Direction=(-1,0)
		Location=(0,_position_)
		Time=1e-10
#		Length=50.0
#		LET_f=120e-7
		Length=@length@
		LET_f=@LET_f@
		Wt_hi=0.1
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
	IncompleteNewton
	ImplicitACSystem
#	NumberOfThreads= maximum
	NumberOfThreads= 6
#if @heavyion@ == 0
	Extrapolate
#endif
#	digits= 8
	digits= 4
	Notdamped= 100
	Iterations= 30
	RelErrControl
	Method= Blocked
# SubMethod= Pardiso
	SubMethod= ILS(set = 3)
	Transient= BE
	ErRef(Electron)=1e10
	ErRef(Hole)=1e10
	CurrentWeighting
#	AvalPostProcessing
#	BreakCriteria{Current(Contact= "Anode_left" AbsVal= _Imax_)}
	ComputeIonizationIntegrals
#	BreakAtIonIntegral(3 1.1)
#if @heavyion@ == 0
	BreakCriteria{Current(Contact= "cathode" AbsVal= _Imax_)}
#endif
}

Solve {
	NewCurrentPrefix= "init_"
	Coupled(Iterations=200){ Poisson _QC_ }
	Coupled{ _EQ_ _QC_}
#if @heavyion@ == 0
	NewCurrentPrefix= "IV_"
	Quasistationary(
		InitialStep= 1e-7 MinStep= 1e-10 MaxStep= 0.01 Increment= 1.41
#if @for_garfield@ == 0
		Goal{ Name="cathode" Voltage= _Vc_ }
#else
		Goal{ Name="cathode" Voltage= _Voper_ }
#endif
	)
	{ Coupled { _EQ_ _QC_}
#		CurrentPlot(Time=(Range=(0 1) Intervals=50))
		}
#	{ ACCoupled (
#		StartFrequency=1e6 EndFrequency=1e6 NumberOfPoints=1 Decade
#		ACCompute (Time = (Range = (0 0.25) Intervals=50))
#		){ _EQ_ _QC_ }
#	}
#else
		NewCurrentPrefix= "ramp_"
		Quasistationary(
			InitialStep= 1e-5 MinStep= 1e-10 MaxStep=0.025 Increment= 1.41
			Goal{ Name="Cathode" Voltage= _Voper_ }
		){ Coupled { _EQ_  _QC_ } 
		}
	NewCurrentPrefix= "transient_"
	Transient(
		InitialTime=0 FinalTime=5e-9
		InitialStep= 1e-12 Increment=1.41
		MinStep= 1e-13 MaxStep= 2e-11
	){ Coupled { _EQ_ _QC_ }
#	Plot ( Time=( 5e-10; 1e-9; 2e-9 ) NoOverwrite )
	}
#endif
	System("rm init_n@node@_des.plt")
}
