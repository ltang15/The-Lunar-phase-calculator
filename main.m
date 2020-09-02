%{The Lunar phase calculator}%

%{Description: getting a valid date input from the command window, then
%calculate the percent illumination of the moon based on the elapsed number
%of days. Besides, displaying the date, illumination and the state of the
%moon corresponding to that date.

clc, clear all, close all;

%% Getting the input
get_d = input('Please enter the day as DD: ', 's');
get_m = upper (input('Please enter the month as MMM: ', 's')); % using upper function for upper cases
get_y = input('Please enter the year as YYYY: ', 's');

%% Validity

%Checking validity for the input format
if (length(get_d) ~= 2 || length (get_m) ~= 3 || length (get_y) ~= 4)
    error('Please input with the correct format DD MMM YYYY');
end

%Checking validity for the day

day = str2double(get_d); %converting string to number

if (day <0 || day > 31)
    error ('Invalid date. That date does not exits.'); 
    
elseif ((contains(get_m,'APR') || contains(get_m,'JUN') || contains(get_m,'SEP') || contains(get_m,'NOV'))&& (day == 31))
    error ('Invalid date.That date does not exits.'); %There are maximum 30 days for those months
     
elseif ((contains(get_m,'FEB'))&& (day > 29))
    error ('Invalid date for FEB'); % Checking special case for Feb
end    


%Checking valadity for day (if it only contains numbers)

if (isnan(str2double (get_d)))
    error ('Invalid input. Only numbers for day.');
elseif (contains(get_d,'.')||contains(get_d,'-'))
    error ('Invalid input. Only numbers for day.');
end  


year = str2double (get_y); %converting string to number

%Checking valadity for year 
%(only contains number and does not exceed the range)

if (isnan(str2double (get_y)))
    error ('Invalid input. Only numbers for year.');
elseif (contains(get_y,'.')||contains(get_y,'-'))
    error ('Invalid input. Only numbers for year.');
elseif (year < 1900 || year > 9999) 
    error ('Invalid input. Year goes from 1900-9999');
end

%% Converting name of month to number

switch (get_m)
    case 'JAN'
        month = 1;
    case 'FEB'
        month = 2; 
    case 'MAR'
        month = 3;
    case 'APR'
        month = 4;
    case 'MAY'
        month = 5;
    case 'JUN'
        month = 6;
    case 'JUL'
        month = 7; 
    case 'AUG'
        month = 8;
    case 'SEP'
        month = 9;
    case 'OCT'
        month = 10;
    case 'NOV'
        month = 11;
    case 'DEC'
        month = 12;
    otherwise
        error ('Invalid month.');
end      
        

%% The elapsed number of days

% Set value for the offset a
if (contains(get_m,'JAN')|| contains(get_m,'FEB'))
    a = 1;
else
    a =0;
end

y = year - a + 4800;
m = month + 12*a -3;

%Calculate the Julian Day number for the input
n_jd = floor(day + ((153*m +2)/5) + (365*y) + (y/4) - (y/100) + (y/400) - 32045);

n0_jd = 2415021;% The Julian Day number for 01 JAN 1900

delta_n = n_jd - n0_jd; % The elapsed number of days


%% Calculate the lunar phase

d = 29.530588853; % number of days in each lunar revolution 

I = (sin(pi*mod(delta_n,d)/d))^2; % the percent illumination of the moon
I_percent = I*100; %converting to percentage

%%Display output
fprintf ('*********\n');
fprintf ('%s %s %s : \n', get_d, get_m, get_y);
fprintf ('Illumination = %1.1f percent.\n', I_percent);

%Check for the state of the moon
if (mod(delta_n,d)/d < 0.5)
    fprintf ('Crescent moon.\n');
else
    fprintf ('Waning moon.\n');
end    
