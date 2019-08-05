function s = parameters()
% PARAMETERS Declare all parameters and store them in a struct s.
% -------------------------------------------------------------------------

    %%% PHYSICAL CONSTANTS:
    s.Lf = 10.0; % Latent heat of fusion of sea ice [W yr m^-3]
    s.ki = 2.0; % Thermal conductivity of sea ice [W m^-1 degC^-1]
    s.RE = 6.37E6; % Mean radius of Earth [m]
    s.Tf = -1.8; % Freezing point of sea water [degC]
    s.Tm = -0.1; % Melting point of sea ice at the top surface [degC]

    %%% MODEL PARAMETERS:
    % ---- Radiative fluxes:
    s.a0 = 0.72; % Planetary coalbedo over ocean at equator [dimensionless]
    s.ai = 0.36; % Planetary coalbedo over sea ice [dimensionless]
    s.a2 = (s.a0-s.ai)/((pi/2)^2); % Planetary coalbedo, phi^2 term coefficient [dimensionless]
    s.dphi = 0.04; % Coalbedo smoothing scale in phi-space [radians]
    s.Aolr = 241; % Outgoing Longwave Radiation (OLR) at Ta=0 degC [W m^-2]
    s.Bolr = 2.4; % OLR linear term coefficient [W m^-2 degC^-1]
    s.Aup = 380; % Upward surface flux, constant term [W m^-2]
    s.Bup = 7.9; % Upward surface flux, coefficient of Ts [W m^-2 degC^-1]
    s.Adn = 335; % Downward surface flux, constant term [W m^-2]
    s.Bdn = 5.9; % Downward surface flux, coefficient of Ta [W m^-2 degC^-1]
    s.Fw = 0; % Top of atmosphere global warming [W m^-2]

    % ---- Heat transports:
    s.Ko = 4.4E11; % Large-scale ocean diffusivity [m^2 yr^-1]
    s.Ka = 2.0E14; % Large-scale atmospheric diffusivity [m^2 yr^-1]
    
    % ---- Deep Ocean Heat Transport Convergence (DOHTC):
    s.psi = 1.3E16; % Overall magnitude parameter [W]
    s.N = 5; % HT peak-position parameter [dimensionless]
    s.Fbp = 2.0;  % DOHTC at the pole for cos(2phi) poleward shift function
                  % (if 0, the whole function is not 'perturbed' from the
                  % prescribed pattern) [W m^-2]

    % ---- Heat capacities:
    s.Ca = 0.3; % Atmosphere column heat capacity [W yr m^-2 degC^-1]
    s.co = 1.27E-4; % Ocean specific heat capacity [W yr kg^-1 degC^-1]
    s.rhoo = 1025; % Density of sea water [kg m^-3]
    s.Hml_const = 75; % Mixed-layer depth when set constant [m]

    % ---- Initial conditions reference points (only used if an initial
    % ---- conditions dataset not provided):
    s.TA_eq = 10; % Initial atmosphere temperature at the equator [degC]
    s.TA_pole = -25; % Initial atmosphere temperature at the pole [degC]
    s.TML_eq = 30; % Initial mixed-layer temperature at the equator [degC]
    s.HI_pole = 3; % Initial sea-ice thickness at the pole [m]
    s.phii_deg_init = 75; % Initial ice-edge latitude [degrees N]
    
end
