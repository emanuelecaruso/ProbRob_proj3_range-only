clear
clc

syms  delta_x_i delta_y_i delta_alpha_i x_i y_i alpha_i real
syms  delta_x_j delta_y_j delta_alpha_j x_j y_j alpha_j real
syms  x_z y_z alpha_z real

Xi=v2t(x_i,y_i,alpha_i);
Xj=v2t(x_j,y_j,alpha_j);
Z=v2t(x_z,y_z,alpha_z);
delta_Xi=v2t(delta_x_i,delta_y_i,delta_alpha_i);
delta_Xj=v2t(delta_x_j,delta_y_j,delta_alpha_j);

% error taken from multipose registration (block 26, slide 16)
e=t2v(inv(Z)*inv(Xi)*inv(delta_Xi)*delta_Xj*Xj);
e=simplify(e);

J_i=jacobian(e,[delta_x_i, delta_y_i, delta_alpha_i]);
J_i=simplify(J_i);

J_j=jacobian(e,[delta_x_j, delta_y_j, delta_alpha_j]);
J_j=simplify(J_j);

J_i_eval=subs(J_i,[delta_x_i delta_y_i delta_alpha_i delta_x_j delta_y_j delta_alpha_j],[0 0 0 0 0 0]);
J_j_eval=subs(J_j,[delta_x_i delta_y_i delta_alpha_i delta_x_j delta_y_j delta_alpha_j],[0 0 0 0 0 0]);

J_i_eval=simplify(J_i_eval);
J_j_eval=simplify(J_j_eval);

pretty(J_i_eval)
pretty(J_j_eval)