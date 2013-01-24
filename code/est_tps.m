function [a1,ax,ay,w]=est_tps(pts,target_value,lamda)
    n=size(pts,1);
    tvalX=repmat(pts(:,1),1,n);
    tvalY=repmat(pts(:,2),1,n);
    diffX=tvalX-transpose(tvalX);
    diffY=tvalY-transpose(tvalY);
    k=(diffX.*diffX)+(diffY.*diffY);
    tmp=(k~=0);
    k=-1*k.*log(k);
    k(tmp==0)=0;
    P=[ones(n,1) pts];
    A=[[k P];[transpose(P) zeros(3,3)]];
    A=A+(lamda*eye(n+3));
    param=(A^-1)*[target_value(:,1);zeros(3,1)];
    w=param(1:n);
    a1=param(n+1);
    ax=param(n+2);
    ay=param(n+3);
end