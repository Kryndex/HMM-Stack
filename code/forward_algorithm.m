function [ fMatrix ] = forward_algorithm( data,param,age_stack,index,rhos,phi )
%% This function generates the forward sum matrix.

% L = length of data in the core
% T = length of age in the stack

% Inputs:
% data: a Lx3-matrix where the first column has the depth indexes and the
% third one has the del-O18 data
% param: a structure of parameters consisting of the following:
% param.mu: a 1xT-vector of means
% param.sigma: a 1xT-vector of standard deviations
% param.shift: a 1xC-vector of shifts
% age_stack: a 1xT-vector of ages in stack
% ETable: file index.
% rhos: a 3x1-cell where the first one is rho_table and the second one is
% grid.
% phi: a hyperparameter for controlling the length of unaligned regions.

% Outputs:
% fMatrix: a TxTxL-forward matrix computed by the forward algorithm

%% Define variables:
T = size(age_stack,2);
L = size(data,1);
fMatrix = zeros(T,T,L);
ETable = Emission_del_O18(data,param,index);
depth = data(:,1);
rho_table = rhos{1};
%grid1 = [log(0.9220),log(1.0850)];
%grid2 = rhos{3};
phi = log(phi);
n = 2;

%% Initial n = 2

emission = ETable(1,:)' + ETable(2,:); % include radiocarbon emision...?
transition = rho_table((age_stack - age_stack')./(depth - depth')); % rho_table...?
fMatrix(:,:,n) = emission + transition + phi; %phi...?
n = n + 1;

%% Iterative n > 2

while n < L
    emission = ETable(n,:);
    transition = %;
    fMatrix(:,:,n) = %;
    n = n + 1;
end

disp('Forward algorithim is done.');

end


%% General questions for Taehee
% - n = 1?
% - Everything is log-probabilities so add not multiply?
% - Use repmat?
% - Shouldn't the iterative case depend on F(n-1,t,t_n-1)?
% - rho (what is the second cell) and phi?
% - T >> L, but what if it is not?
% - Shouldn't the data be reversed?  Align oldest => newest?
% - Why is fMatrix (TxTxL) and not (TxL)?
