import { dbank } from "../../declarations/dbank";

// Update the current balance on the account
window.addEventListener("load", async function() {
  update();
});

document.querySelector("form").addEventListener("submit", async function(event) {
  event.preventDefault();

  const button = event.target.querySelector("#submit-btn");

  const depositAmount = parseFloat(document.getElementById("deposit-amount").value);
  const withdrawAmount = parseFloat(document.getElementById("withdraw-amount").value);

  button.setAttribute("disabled", true);

  if (document.getElementById("deposit-amount").value.length != 0) {
    await dbank.deposit(depositAmount);
  }
  if (document.getElementById("withdraw-amount").value.length != 0) {
    await dbank.withdraw(withdrawAmount);
  }

  update();

  document.getElementById("deposit-amount").value = "";
  document.getElementById("withdraw-amount").value = "";

  button.removeAttribute("disabled");

  
});

async function update() {
  const currentAmount = await dbank.checkBalance();
  document.getElementById("value").innerText = Math.round(currentAmount * 100) / 100;
}