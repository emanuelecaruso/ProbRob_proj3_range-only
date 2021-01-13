function midpoint = midpoint_between_2_circles_intersections(center_1, center_2, radius_1, radius_2)

  %###########################################################################
  %intersections between 2 circles: code taken from
  %https://matlab.programmingpedia.net/en/knowledge-base/5238566/intersection-points-of-two-circles-in-matlab

  A = [center_1(1) center_1(2)]; %# center of the first circle
  B = [center_2(1) center_2(2)]; %# center of the second circle
  a = radius_2; %# radius of the SECOND circle
  b = radius_1; %# radius of the FIRST circle
  c = norm(A-B); %# distance between circles

  cosAlpha = (b^2+c^2-a^2)/(2*b*c);

  u_AB = (B - A)/c; %# unit vector from first to second center
  pu_AB = [u_AB(2), -u_AB(1)]; %# perpendicular vector to unit vector

  %# use the cosine of alpha to calculate the length of the
  %# vector along and perpendicular to AB that leads to the
  %# intersection point
  intersect_1 = A + u_AB * (b*cosAlpha) + pu_AB * (b*sqrt(1-cosAlpha^2));
  intersect_2 = A + u_AB * (b*cosAlpha) - pu_AB * (b*sqrt(1-cosAlpha^2));

  %###########################################################################

  %compute midpoint between the 2 intersections
  midpoint=[(intersect_1(1)+intersect_2(1))/2 , (intersect_1(2)+intersect_2(2))/2];
end
