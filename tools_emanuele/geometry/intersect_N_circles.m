function intersection = intersect_N_circles(centers,radii)
  num_circles=length(centers);

  A=[];
  b=[];
  %compute linear system of num_circles intersections
  for i=2:num_circles
    A= [A; 2*[centers(1).x-centers(i).x, centers(1).y-centers(i).y]];
    b=[b; (radii(i)^2)-(radii(1)^2)+(centers(1).y^2)-(centers(i).y^2)+(centers(1).x^2)-(centers(i).x^2)];
  end

  %check singularities
  %if both singular values are very small (rank=~0), all circles are very close
  %so initialize the guess at the center of the first circle
  if sum(svd(A))<0.1
    intersection=[centers(1).x;centers(1).y];
  %if only 1 singular value is very small (rank=~1), there are mainly 2 different circles
  %among all the circles, compute the midpoint between the 2 intersections between the 2 different circles
  elseif svd(A)(2)<0.1
    first_center=[centers(1).x;centers(1).y];
    first_radius=radii(1);
    for i=1:size(A)(1)
      if norm(A(i,:))>0.1
        second_center=[centers(i+1).x;centers(i+1).y];
        second_radius=radii(i+1);
        break;
      end
    end
    intersection=midpoint_between_2_circles_intersections(first_center, second_center, first_radius, second_radius);
  %else solve the linear system
  else
    intersection=pinv(A)*b;
  end
end
