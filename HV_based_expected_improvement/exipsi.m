function x=exipsi(a,b,m,s)
 x= s*gausspdf((b-m)/s) + (a-m)*gausscdf((b-m)/s);
