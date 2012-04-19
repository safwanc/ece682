function [ Afeedback ] = StateFeedback( A, B, Poles )
%STATEFEEDBACK Computes the augmented system 'A - Bk'
%
% Course:       ECE 682 (Fall 2011)
%               Multivariate Control Systems
%
% Author:       Safwan Choudhury, MASc
%               University of Waterloo
%
% See also:     DESIGNSTATEFEEDBACK PLOTPOLEZERO PLOTSTEPRESPONSE

% Email:        schoudhu@uwaterloo.ca
% Website:      http://ece.uwaterloo.ca/~schoudhu

    Q = ctrb(A,B);
    M = [ Q(:,1) Q(:,3) Q(:,5) Q(:,2) Q(:,4) Q(:,6) ];
    Minv = inv(M); e1 = Minv(3,:); e2 = Minv(6,:);
    P = [e1; e1*A; e1*(A^2); (e2.^2); (e2.^2)*A; (e2.^2)*(A^2)];
    Abar = P*A/(P); Bbar = P*B; 
    Kbar = place(Abar,Bbar, Poles);

    K = Kbar * P;

    Afeedback = A - B * K; 
end

