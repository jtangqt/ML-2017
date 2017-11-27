function h = plot_gaussian_ellipsoid(m, C, sdwidth, npts, axh)
% PLOT_GAUSSIAN_ELLIPSOIDS plots 2-d and 3-d Gaussian distributions
%
% H = PLOT_GAUSSIAN_ELLIPSOIDS(M, C) plots the distribution specified by 
%  mean M and covariance C. The distribution is plotted as an ellipse (in 
%  2-d) or an ellipsoid (in 3-d).  By default, the distributions are 
%  plotted in the current axes. H is the graphics handle to the plotted 
%  ellipse or ellipsoid.
%
% PLOT_GAUSSIAN_ELLIPSOIDS(M, C, SD) uses SD as the standard deviation 
%  along the major and minor axes (larger SD => larger ellipse). By 
%  default, SD = 1. Note: 
%  * For 2-d distributions, SD=1.0 and SD=2.0 cover ~ 39% and 86% 
%     of the total probability mass, respectively. 
%  * For 3-d distributions, SD=1.0 and SD=2.0 cover ~ 19% and 73%
%     of the total probability mass, respectively.
%  
% PLOT_GAUSSIAN_ELLIPSOIDS(M, C, SD, NPTS) plots the ellipse or 
%  ellipsoid with a resolution of NPTS (ellipsoids are generated 
%  on an NPTS x NPTS mesh; see SPHERE for more details). By
%  default, NPTS = 50 for ellipses, and 20 for ellipsoids.
%
% PLOT_GAUSSIAN_ELLIPSOIDS(M, C, SD, NPTS, AX) adds the plot to the
%  axes specified by the axis handle AX.
%
% Examples: 
% -------------------------------------------
%  % Plot three 2-d Gaussians
%  figure; 
%  h1 = plot_gaussian_ellipsoid([1 1], [1 0.5; 0.5 1]);
%  h2 = plot_gaussian_ellipsoid([2 1.5], [1 -0.7; -0.7 1]);
%  h3 = plot_gaussian_ellipsoid([0 0], [1 0; 0 1]);
%  set(h2,'color','r'); 
%  set(h3,'color','g');
% 
%  % "Contour map" of a 2-d Gaussian
%  figure;
%  for sd = [0.3:0.4:4],
%    h = plot_gaussian_ellipsoid([0 0], [1 0.8; 0.8 1], sd);
%  end

% -------------------------------------------
% 
%  Gautam Vallabha, Sep-23-2007, Gautam.Vallabha@mathworks.com

%  Revision 1.0, Sep-23-2007
%    - File created
%  Revision 1.1, 26-Sep-2007
%    - NARGOUT==0 check added.
%    - Help added on NPTS for ellipsoids

    if ~exist('sdwidth', 'var'), sdwidth = 1; end
    if ~exist('npts', 'var'), npts = []; end
    if ~exist('axh', 'var'), axh = gca; end

    if numel(m) ~= length(m) 
        error('M must be a vector'); 
    end
    if ~( all(numel(m) == size(C)) )
        error('Dimensionality of M and C must match');
    end
    if ~(isscalar(axh) && ishandle(axh) && strcmp(get(axh,'type'), 'axes'))
        error('Invalid axes handle');
    end

    set(axh, 'nextplot', 'add');

    switch numel(m)
       case 2, h=show2d(m(:),C,sdwidth,npts,axh);
       %case 3, h=show3d(m(:),C,sdwidth,npts,axh);
       otherwise
          error('Unsupported dimensionality');
    end

    if nargout==0
        clear h;
    end 
end