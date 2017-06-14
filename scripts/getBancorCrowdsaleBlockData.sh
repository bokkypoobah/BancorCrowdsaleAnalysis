#!/bin/sh
# ----------------------------------------------------------------------------------------------
# Extrating transaction data from the Bancor ICO
#
# Enjoy. (c) BokkyPooBah / Bok Consulting Pty Ltd 2017. The MIT Licence.
# ----------------------------------------------------------------------------------------------

geth attach << EOF | grep "RESULT: " | sed "s/RESULT: //"
// geth attach << EOF

var icoAddress = "0xbbc79794599b19274850492394004087cbf89710";
var icoABI = [{"constant":true,"inputs":[],"name":"BTCS_ETHER_CAP","outputs":[{"name":"","type":"uint256"}],"payable":false,"type":"function"},{"constant":true,"inputs":[],"name":"TOKEN_PRICE_D","outputs":[{"name":"","type":"uint256"}],"payable":false,"type":"function"},{"constant":false,"inputs":[],"name":"contributeETH","outputs":[{"name":"amount","type":"uint256"}],"payable":true,"type":"function"},{"constant":true,"inputs":[],"name":"DURATION","outputs":[{"name":"","type":"uint256"}],"payable":false,"type":"function"},{"constant":true,"inputs":[{"name":"_contribution","type":"uint256"}],"name":"computeReturn","outputs":[{"name":"","type":"uint256"}],"payable":false,"type":"function"},{"constant":false,"inputs":[{"name":"_newOwner","type":"address"}],"name":"transferTokenOwnership","outputs":[],"payable":false,"type":"function"},{"constant":true,"inputs":[],"name":"endTime","outputs":[{"name":"","type":"uint256"}],"payable":false,"type":"function"},{"constant":true,"inputs":[],"name":"totalEtherCap","outputs":[{"name":"","type":"uint256"}],"payable":false,"type":"function"},{"constant":false,"inputs":[],"name":"acceptTokenOwnership","outputs":[],"payable":false,"type":"function"},{"constant":true,"inputs":[],"name":"beneficiary","outputs":[{"name":"","type":"address"}],"payable":false,"type":"function"},{"constant":false,"inputs":[{"name":"_token","type":"address"},{"name":"_to","type":"address"},{"name":"_amount","type":"uint256"}],"name":"withdrawFromToken","outputs":[],"payable":false,"type":"function"},{"constant":true,"inputs":[],"name":"TOKEN_PRICE_N","outputs":[{"name":"","type":"uint256"}],"payable":false,"type":"function"},{"constant":false,"inputs":[{"name":"_to","type":"address"},{"name":"_amount","type":"uint256"}],"name":"issueTokens","outputs":[],"payable":false,"type":"function"},{"constant":true,"inputs":[],"name":"version","outputs":[{"name":"","type":"string"}],"payable":false,"type":"function"},{"constant":false,"inputs":[{"name":"_token","type":"address"},{"name":"_to","type":"address"},{"name":"_amount","type":"uint256"}],"name":"withdrawTokens","outputs":[],"payable":false,"type":"function"},{"constant":true,"inputs":[],"name":"startTime","outputs":[{"name":"","type":"uint256"}],"payable":false,"type":"function"},{"constant":false,"inputs":[],"name":"acceptOwnership","outputs":[],"payable":false,"type":"function"},{"constant":false,"inputs":[{"name":"_disable","type":"bool"}],"name":"disableTokenTransfers","outputs":[],"payable":false,"type":"function"},{"constant":true,"inputs":[],"name":"owner","outputs":[{"name":"","type":"address"}],"payable":false,"type":"function"},{"constant":true,"inputs":[],"name":"realEtherCapHash","outputs":[{"name":"","type":"bytes32"}],"payable":false,"type":"function"},{"constant":false,"inputs":[{"name":"_cap","type":"uint256"},{"name":"_key","type":"uint256"}],"name":"enableRealCap","outputs":[],"payable":false,"type":"function"},{"constant":false,"inputs":[],"name":"contributeBTCs","outputs":[{"name":"amount","type":"uint256"}],"payable":true,"type":"function"},{"constant":true,"inputs":[],"name":"totalEtherContributed","outputs":[{"name":"","type":"uint256"}],"payable":false,"type":"function"},{"constant":true,"inputs":[],"name":"btcs","outputs":[{"name":"","type":"address"}],"payable":false,"type":"function"},{"constant":false,"inputs":[{"name":"_from","type":"address"},{"name":"_amount","type":"uint256"}],"name":"destroyTokens","outputs":[],"payable":false,"type":"function"},{"constant":true,"inputs":[],"name":"newOwner","outputs":[{"name":"","type":"address"}],"payable":false,"type":"function"},{"constant":true,"inputs":[{"name":"_cap","type":"uint256"},{"name":"_key","type":"uint256"}],"name":"computeRealCap","outputs":[{"name":"","type":"bytes32"}],"payable":false,"type":"function"},{"constant":true,"inputs":[],"name":"MAX_GAS_PRICE","outputs":[{"name":"","type":"uint256"}],"payable":false,"type":"function"},{"constant":false,"inputs":[{"name":"_newOwner","type":"address"}],"name":"transferOwnership","outputs":[],"payable":false,"type":"function"},{"constant":true,"inputs":[],"name":"token","outputs":[{"name":"","type":"address"}],"payable":false,"type":"function"},{"inputs":[{"name":"_token","type":"address"},{"name":"_startTime","type":"uint256"},{"name":"_beneficiary","type":"address"},{"name":"_btcs","type":"address"},{"name":"_realEtherCapHash","type":"bytes32"}],"payable":false,"type":"constructor"},{"payable":true,"type":"fallback"},{"anonymous":false,"inputs":[{"indexed":true,"name":"_contributor","type":"address"},{"indexed":false,"name":"_amount","type":"uint256"},{"indexed":false,"name":"_return","type":"uint256"}],"name":"Contribution","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"name":"_prevOwner","type":"address"},{"indexed":false,"name":"_newOwner","type":"address"}],"name":"OwnerUpdate","type":"event"}];
var ico = web3.eth.contract(icoABI).at(icoAddress);

var icoFirstTxBlock = 3861203;
var icoLastTxBlock = 3861767;
// icoLastTxBlock = parseInt(icoFirstTxBlock) + 2;
var totalEthers = new BigNumber(0);
var totalTokens = new BigNumber(0);

function getBlockData() {
  var count = 0;
  console.log("RESULT: Block\tTimestamp\tDateTime\t#BancorTxs\tNonBancorTxs\t#BancorErrorTxs\tNonBancorErrorTxs\tBancor%\tBlockGasUsed\tBlockGasLimit\tUsed%\tMiner");
  for (var i = icoFirstTxBlock; i <= icoLastTxBlock; i++) {
    var block = eth.getBlock(i, true);
    var blockGasUsed = block.gasUsed;
    var blockGasLimit = block.gasLimit;
    var timestamp = block.timestamp;
    var time = new Date(timestamp * 1000);
    var bancorTxs = 0;
    var nonBancorTxs = 0;
    var bancorErrorTxs = 0;
    var nonBancorErrorTxs = 0;
    if (block != null && block.transactions != null) {
      block.transactions.forEach( function(e) {
        var status = debug.traceTransaction(e.hash);
        var txOk = true;
        if (status.structLogs.length > 0) {
            if (status.structLogs[status.structLogs.length-1].error) {
             txOk = false;
          }
        }
        if (e.to == icoAddress) {
          if (txOk) {
            bancorTxs++;
          } else {
            bancorErrorTxs;
          }
        }  else {
          if (txOk) {
            nonBancorTxs++;
          } else {
            nonBancorErrorTxs++;
          }
        }
      });
      var usedPercent = blockGasUsed * 100 / blockGasLimit;
      var total = bancorTxs + bancorErrorTxs + nonBancorTxs + nonBancorErrorTxs;
      var bancorPercent = total == 0 ? 0 : (bancorTxs + bancorErrorTxs) * 100 / total;
      console.log("RESULT: " + i + "\t" + timestamp + "\t" + time.toUTCString() +
        "\t" + bancorTxs + "\t" + nonBancorTxs + "\t" + bancorErrorTxs + "\t" + nonBancorErrorTxs + "\t" + bancorPercent + 
        "\t" + blockGasUsed + "\t" + blockGasLimit + "\t" + usedPercent + "\t" + block.miner);
    }
  }
}

getBlockData();

EOF
