**free
ctl-opt dftactgrp(*no) actgrp(*caller);

dcl-pr QCMDEXC extpgm('QCMDEXC');
  cmdstring  varchar(2000);
  cmdlength  packed(15:5);
end-pr;

dcl-pi *n;
  userInput char(200);
end-pi;

dcl-s cmdstring varchar(2000);

cmdstring = 'DLYJOB ' + %trim(userInput);

QCMDEXC(cmdstring: %len(%trim(cmdstring)));

*inlr = *on;
return;
