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
var icoABI = [{"anonymous":false,"inputs":[{"indexed":true,"name":"_contributor","type":"address"},{"indexed":false,"name":"_amount","type":"uint256"},{"indexed":false,"name":"_return","type":"uint256"}],"name":"Contribution","type":"event"}];
var tokenAddress = "0x1f573d6fb3f13d689ff844b4ce37794d79a7ff1c";
var tokenABI = [{"constant":true,"inputs":[],"name":"name","outputs":[{"name":"","type":"string"}],"payable":false,"type":"function"},{"constant":false,"inputs":[{"name":"_spender","type":"address"},{"name":"_value","type":"uint256"}],"name":"approve","outputs":[{"name":"success","type":"bool"}],"payable":false,"type":"function"},{"constant":false,"inputs":[{"name":"_disable","type":"bool"}],"name":"disableTransfers","outputs":[],"payable":false,"type":"function"},{"constant":true,"inputs":[],"name":"totalSupply","outputs":[{"name":"","type":"uint256"}],"payable":false,"type":"function"},{"constant":false,"inputs":[{"name":"_from","type":"address"},{"name":"_to","type":"address"},{"name":"_value","type":"uint256"}],"name":"transferFrom","outputs":[{"name":"success","type":"bool"}],"payable":false,"type":"function"},{"constant":true,"inputs":[],"name":"decimals","outputs":[{"name":"","type":"uint8"}],"payable":false,"type":"function"},{"constant":true,"inputs":[],"name":"version","outputs":[{"name":"","type":"string"}],"payable":false,"type":"function"},{"constant":true,"inputs":[],"name":"standard","outputs":[{"name":"","type":"string"}],"payable":false,"type":"function"},{"constant":false,"inputs":[{"name":"_token","type":"address"},{"name":"_to","type":"address"},{"name":"_amount","type":"uint256"}],"name":"withdrawTokens","outputs":[],"payable":false,"type":"function"},{"constant":true,"inputs":[{"name":"","type":"address"}],"name":"balanceOf","outputs":[{"name":"","type":"uint256"}],"payable":false,"type":"function"},{"constant":false,"inputs":[],"name":"acceptOwnership","outputs":[],"payable":false,"type":"function"},{"constant":false,"inputs":[{"name":"_to","type":"address"},{"name":"_amount","type":"uint256"}],"name":"issue","outputs":[],"payable":false,"type":"function"},{"constant":true,"inputs":[],"name":"owner","outputs":[{"name":"","type":"address"}],"payable":false,"type":"function"},{"constant":true,"inputs":[],"name":"symbol","outputs":[{"name":"","type":"string"}],"payable":false,"type":"function"},{"constant":false,"inputs":[{"name":"_from","type":"address"},{"name":"_amount","type":"uint256"}],"name":"destroy","outputs":[],"payable":false,"type":"function"},{"constant":false,"inputs":[{"name":"_to","type":"address"},{"name":"_value","type":"uint256"}],"name":"transfer","outputs":[{"name":"success","type":"bool"}],"payable":false,"type":"function"},{"constant":true,"inputs":[],"name":"transfersEnabled","outputs":[{"name":"","type":"bool"}],"payable":false,"type":"function"},{"constant":true,"inputs":[],"name":"newOwner","outputs":[{"name":"","type":"address"}],"payable":false,"type":"function"},{"constant":true,"inputs":[{"name":"","type":"address"},{"name":"","type":"address"}],"name":"allowance","outputs":[{"name":"","type":"uint256"}],"payable":false,"type":"function"},{"constant":false,"inputs":[{"name":"_newOwner","type":"address"}],"name":"transferOwnership","outputs":[],"payable":false,"type":"function"},{"inputs":[{"name":"_name","type":"string"},{"name":"_symbol","type":"string"},{"name":"_decimals","type":"uint8"}],"payable":false,"type":"constructor"},{"anonymous":false,"inputs":[{"indexed":false,"name":"_token","type":"address"}],"name":"NewSmartToken","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"name":"_amount","type":"uint256"}],"name":"Issuance","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"name":"_amount","type":"uint256"}],"name":"Destruction","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"name":"_prevOwner","type":"address"},{"indexed":false,"name":"_newOwner","type":"address"}],"name":"OwnerUpdate","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"name":"_from","type":"address"},{"indexed":true,"name":"_to","type":"address"},{"indexed":false,"name":"_value","type":"uint256"}],"name":"Transfer","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"name":"_owner","type":"address"},{"indexed":true,"name":"_spender","type":"address"},{"indexed":false,"name":"_value","type":"uint256"}],"name":"Approval","type":"event"}];
var ico = web3.eth.contract(icoABI).at(icoAddress);
var token = web3.eth.contract(tokenABI).at(tokenAddress);
var ownerWallet = "0x51a3ac2399c89ffa893b0f627c740c05193875a6";

var icoFirstTxBlock = 3861203;
var icoLastTxBlock = 3861767;
// var icoLastTxBlock = parseInt(icoFirstTxBlock) + 2;
var totalEthers = new BigNumber(0);
var totalTokens = new BigNumber(0);


function getEtherData() {
  console.log("RESULT: Account\tBlock\tTxIdx\t#\tEthers\tSumEthers\tTokens\tSumTokens\tTimestamp\tDateTime\tData\tTxHash\tBlockGasUsed\tBlockGasLimit\tGasUsed\tGasPrice\tGasCost");
  var count = 0;
  for (var i = icoFirstTxBlock; i <= icoLastTxBlock; i++) {
    var block = eth.getBlock(i, true);
    var blockGasUsed = block.gasUsed;
    var blockGasLimit = block.gasLimit;
    var timestamp = block.timestamp;
    var time = new Date(timestamp * 1000);
    if (block != null && block.transactions != null) {
      block.transactions.forEach( function(e) {
        // console.log("DEBUG: " + JSON.stringify(e));
        var status = debug.traceTransaction(e.hash);
        var txOk = true;
        if (status.structLogs.length > 0) {
            if (status.structLogs[status.structLogs.length-1].error) {
             txOk = false;
          }
        }
        if ((e.to == icoAddress || e.to == ownerWallet) && txOk) { //  && e.input != "0x" ) { // && "0xb4427263" == e.input ) {
          // console.log("DEBUG: --- input=" + e.input + " ---");
          // console.log("DEBUG: " + JSON.stringify(e));
          count++;
          var ethers = web3.fromWei(e.value, "ether");
          totalEthers = totalEthers.add(ethers);
          var tokenBalancePrev = token.balanceOf(e.from, parseInt(e.blockNumber) - 1).div(1e18);
          var tokenBalance = token.balanceOf(e.from, e.blockNumber).div(1e18).minus(tokenBalancePrev);
          totalTokens = totalTokens.add(tokenBalance);
          var txr = eth.getTransactionReceipt(e.hash);
          var gasUsed = new BigNumber(txr.gasUsed);
          var gasPrice = e.gasPrice;
          var gasCost = gasUsed.times(gasPrice);
          console.log("RESULT: " + e.from + "\t" + e.blockNumber + "\t" + e.transactionIndex + "\t" + count + "\t" + ethers + "\t" + 
            totalEthers + "\t" + tokenBalance + "\t" + totalTokens + "\t" + timestamp + "\t" + time.toUTCString() + "\t" + 
            e.input + "\t" + e.hash + "\t" + blockGasUsed + "\t" + blockGasLimit +
            "\t" + gasUsed + "\t" + web3.fromWei(gasPrice, "ether") + "\t" + web3.fromWei(gasCost, "ether"));
        }
      });
    }
  }
}

function getEventData() {
  console.log("RESULT: No\tAddress\tEthers\tSumEthers\tTokens\tSumTokens\tBlockNumber\tTxIndx\tTimestamp\tTime\tTxHash");
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
    var ethers = web3.fromWei(result.args._amount, "ether");
    totalEthers = totalEthers.add(ethers);
    var tokens = result.args._return.shift(-18);
    totalTokens = totalTokens.add(tokens);

    // event Contribution(address indexed _contributor, uint256 _amount, uint256 _return);
    console.log("RESULT: " + i++ + "\t" + result.args._contributor +
      "\t" + ethers + "\t" + totalEthers +
      "\t" + tokens + "\t" + totalTokens +
      "\t" + result.blockNumber + "\t" + result.transactionIndex +
      "\t" + block.timestamp + "\t" + time +
      "\t" + result.transactionHash);
  });
  contributionEvent.stopWatching();
}

// getEtherData();

getEventData();

EOF
