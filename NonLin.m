function dz = NonLin (t,z)

global N1 N2 b1 b2 ct kt J1 J2 Jm a bm cnl mu



dz = zeros(5,1); %Create a column vector with zeros at all indices

dz(1) = z(2);

dz(2) = (z(5) - (kt/((N1*N2)^2))*z(1) - (ct/((N1*N2)^2))*z(2) - b1*z(2) + (kt/(N1*N2))*z(3) + (ct/(N1*N2))*z(4))/J1 ;

dz(3) = z(4);

dz(4) = ( (kt/(N1*N2))*z(1) + (ct/(N1*N2))*z(2)  - kt*z(3) - b2*z(4) - cnl*(z(4)^2.65) - (mu*(z(4)^3 + z(4))*sign(z(4))))/J2;

dz(5) = (a - bm*z(5))/Jm;



end