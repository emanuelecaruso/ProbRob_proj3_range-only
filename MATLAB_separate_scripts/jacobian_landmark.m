clear
clc

syms  delta_x delta_y delta_alpha x y alpha X_l_x X_l_y delta_X_l_x delta_X_l_y z  ;

delta_X_l=[delta_X_l_x;delta_X_l_y];
X_l=[X_l_x; X_l_y];
T=v2t(x, y, alpha);
delta_T=v2t(delta_x, delta_y, delta_alpha);

% h(x boxplus dx) = || T^-1 delta_T^-1 (X_l + delta_X_l) ||
g=inv(T)*inv(delta_T)*([X_l+delta_X_l;1]);
h_icp=norm(g);
h_icp=simplify(h_icp);
e =h_icp-z;

J_i=jacobian(e,[delta_x, delta_y, delta_alpha]);
J_i=simplify(J_i);

J_j=jacobian(e,[delta_X_l_x, delta_X_l_y]);
J_j=simplify(J_j);

J_i_eval=subs(J_i,[delta_x delta_y delta_alpha, delta_X_l_x, delta_X_l_y],[0 0 0 0 0]);
J_j_eval=subs(J_j,[delta_x delta_y delta_alpha, delta_X_l_x, delta_X_l_y],[0 0 0 0 0]);

J_i_eval=simplify(J_i_eval);
J_j_eval=simplify(J_j_eval);

pretty(J_i_eval)
pretty(J_j_eval)