#!/bin/sh
# ----------------------------------------------------------------------------------------------
# Extrating transaction data from the Bancor ICO
#
# Enjoy. (c) BokkyPooBah / Bok Consulting Pty Ltd 2017. The MIT Licence.
# ----------------------------------------------------------------------------------------------

geth attach << EOF | grep "RESULT: " | sed "s/RESULT: //"
// geth attach << EOF

var icoAddress = "0xbbc79794599b19274850492394004087cbf89710";
// var icoABI = [{"constant":true,"inputs":[],"name":"BTCS_ETHER_CAP","outputs":[{"name":"","type":"uint256"}],"payable":false,"type":"function"},{"constant":true,"inputs":[],"name":"TOKEN_PRICE_D","outputs":[{"name":"","type":"uint256"}],"payable":false,"type":"function"},{"constant":false,"inputs":[],"name":"contributeETH","outputs":[{"name":"amount","type":"uint256"}],"payable":true,"type":"function"},{"constant":true,"inputs":[],"name":"DURATION","outputs":[{"name":"","type":"uint256"}],"payable":false,"type":"function"},{"constant":true,"inputs":[{"name":"_contribution","type":"uint256"}],"name":"computeReturn","outputs":[{"name":"","type":"uint256"}],"payable":false,"type":"function"},{"constant":false,"inputs":[{"name":"_newOwner","type":"address"}],"name":"transferTokenOwnership","outputs":[],"payable":false,"type":"function"},{"constant":true,"inputs":[],"name":"endTime","outputs":[{"name":"","type":"uint256"}],"payable":false,"type":"function"},{"constant":true,"inputs":[],"name":"totalEtherCap","outputs":[{"name":"","type":"uint256"}],"payable":false,"type":"function"},{"constant":false,"inputs":[],"name":"acceptTokenOwnership","outputs":[],"payable":false,"type":"function"},{"constant":true,"inputs":[],"name":"beneficiary","outputs":[{"name":"","type":"address"}],"payable":false,"type":"function"},{"constant":false,"inputs":[{"name":"_token","type":"address"},{"name":"_to","type":"address"},{"name":"_amount","type":"uint256"}],"name":"withdrawFromToken","outputs":[],"payable":false,"type":"function"},{"constant":true,"inputs":[],"name":"TOKEN_PRICE_N","outputs":[{"name":"","type":"uint256"}],"payable":false,"type":"function"},{"constant":false,"inputs":[{"name":"_to","type":"address"},{"name":"_amount","type":"uint256"}],"name":"issueTokens","outputs":[],"payable":false,"type":"function"},{"constant":true,"inputs":[],"name":"version","outputs":[{"name":"","type":"string"}],"payable":false,"type":"function"},{"constant":false,"inputs":[{"name":"_token","type":"address"},{"name":"_to","type":"address"},{"name":"_amount","type":"uint256"}],"name":"withdrawTokens","outputs":[],"payable":false,"type":"function"},{"constant":true,"inputs":[],"name":"startTime","outputs":[{"name":"","type":"uint256"}],"payable":false,"type":"function"},{"constant":false,"inputs":[],"name":"acceptOwnership","outputs":[],"payable":false,"type":"function"},{"constant":false,"inputs":[{"name":"_disable","type":"bool"}],"name":"disableTokenTransfers","outputs":[],"payable":false,"type":"function"},{"constant":true,"inputs":[],"name":"owner","outputs":[{"name":"","type":"address"}],"payable":false,"type":"function"},{"constant":true,"inputs":[],"name":"realEtherCapHash","outputs":[{"name":"","type":"bytes32"}],"payable":false,"type":"function"},{"constant":false,"inputs":[{"name":"_cap","type":"uint256"},{"name":"_key","type":"uint256"}],"name":"enableRealCap","outputs":[],"payable":false,"type":"function"},{"constant":false,"inputs":[],"name":"contributeBTCs","outputs":[{"name":"amount","type":"uint256"}],"payable":true,"type":"function"},{"constant":true,"inputs":[],"name":"totalEtherContributed","outputs":[{"name":"","type":"uint256"}],"payable":false,"type":"function"},{"constant":true,"inputs":[],"name":"btcs","outputs":[{"name":"","type":"address"}],"payable":false,"type":"function"},{"constant":false,"inputs":[{"name":"_from","type":"address"},{"name":"_amount","type":"uint256"}],"name":"destroyTokens","outputs":[],"payable":false,"type":"function"},{"constant":true,"inputs":[],"name":"newOwner","outputs":[{"name":"","type":"address"}],"payable":false,"type":"function"},{"constant":true,"inputs":[{"name":"_cap","type":"uint256"},{"name":"_key","type":"uint256"}],"name":"computeRealCap","outputs":[{"name":"","type":"bytes32"}],"payable":false,"type":"function"},{"constant":true,"inputs":[],"name":"MAX_GAS_PRICE","outputs":[{"name":"","type":"uint256"}],"payable":false,"type":"function"},{"constant":false,"inputs":[{"name":"_newOwner","type":"address"}],"name":"transferOwnership","outputs":[],"payable":false,"type":"function"},{"constant":true,"inputs":[],"name":"token","outputs":[{"name":"","type":"address"}],"payable":false,"type":"function"},{"inputs":[{"name":"_token","type":"address"},{"name":"_startTime","type":"uint256"},{"name":"_beneficiary","type":"address"},{"name":"_btcs","type":"address"},{"name":"_realEtherCapHash","type":"bytes32"}],"payable":false,"type":"constructor"},{"payable":true,"type":"fallback"},{"anonymous":false,"inputs":[{"indexed":true,"name":"_contributor","type":"address"},{"indexed":false,"name":"_amount","type":"uint256"},{"indexed":false,"name":"_return","type":"uint256"}],"name":"Contribution","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"name":"_prevOwner","type":"address"},{"indexed":false,"name":"_newOwner","type":"address"}],"name":"OwnerUpdate","type":"event"}];
var icoABIFragment = [{"anonymous":false,"inputs":[{"indexed":true,"name":"_contributor","type":"address"},{"indexed":false,"name":"_amount","type":"uint256"},{"indexed":false,"name":"_return","type":"uint256"}],"name":"Contribution","type":"event"}, {"constant":true,"inputs":[],"name":"totalEtherContributed","outputs":[{"name":"","type":"uint256"}],"payable":false,"type":"function"}, {"constant":true,"inputs":[],"name":"totalEtherCap","outputs":[{"name":"","type":"uint256"}],"payable":false,"type":"function"}];
var ico = web3.eth.contract(icoABIFragment).at(icoAddress);

var totalEthers = new BigNumber(0);
var totalTokens = new BigNumber(0);

function getEventData() {
  console.log("RESULT: No\tAddress\tEthers\tSumEthers\ttotalEtherContributed\ttotalEtherCap\tExcess\tTokens\tSumTokens\tBlockNumber\tTxIndx\tTimestamp\tTime\tTxHash");
  var firstBlock = 3851207;
  // TEST var firstBlock = 3851003;
  var lastBlock = 3861767;
  // TEST var lastBlock = 3861203;
  var i = 0;
  var block = null;
  var time = "";
  var contributionEvent = ico.Contribution({}, {fromBlock: firstBlock, toBlock: lastBlock});
  contributionEvent.watch(function (error, result) {
    if (block == null || result.blockNumber != block.number) {
      block = eth.getBlock(result.blockNumber);
      time = new Date(block.timestamp * 1000);
    }
    // var totalEtherContributedData = web3.eth.call({to: icoAddress, data: "0xb591fc69"}, result.blockNumber);
    // var totalEtherContributed = new BigNumber(totalEtherContributedData.substring(2, totalEtherContributedData.length), 16).shift(-18);
    var totalEtherContributed = ico.totalEtherContributed(result.blockNumber).shift(-18);
    var totalEtherCap = ico.totalEtherCap(result.blockNumber).shift(-18);
    var excess = totalEtherContributed.comparedTo(totalEtherCap) < 0 ? new BigNumber(0) : totalEtherContributed.minus(totalEtherCap);  
    var ethers = web3.fromWei(result.args._amount, "ether");
    totalEthers = totalEthers.add(ethers);
    var tokens = result.args._return.shift(-18);
    totalTokens = totalTokens.add(tokens);
    console.log("RESULT: " + i++ + "\t" + result.args._contributor +
      "\t" + ethers + "\t" + totalEthers +
      "\t" + totalEtherContributed + "\t" + totalEtherCap + "\t" + excess +
      "\t" + tokens + "\t" + totalTokens +
      "\t" + result.blockNumber + "\t" + result.transactionIndex +
      "\t" + block.timestamp + "\t" + time +
      "\t" + result.transactionHash);
  });
  contributionEvent.stopWatching();
}

getEventData();

EOF
