*** |  (C) 2008-2019 Potsdam Institute for Climate Impact Research (PIK),
*** |  authors, and contributors see CITATION.cff file
*** |  This file is part of MAgPIE and licensed under GNU AGPL Version 3
*** |  or later. See LICENSE file or go to http://www.gnu.org/licenses/
*** |  Contact: magpie@pik-potsdam.de

*' @code
*' Accordingly, this implementation sets the cost of technical mitigation of GHG emissions (`vm_maccs_costs`)
*' to zero. Please see and compare this with the equation in the next realization.

vm_maccs_costs.fx(i) = 0;
im_maccs_mitigation(t,i,emis_source,pollutants) = 0;
