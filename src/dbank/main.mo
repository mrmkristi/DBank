// Debug module in order to use "print"
import Debug "mo:base/Debug";
import Nat "mo:base/Nat";
import Time "mo:base/Time";
import Float "mo:base/Float";

// creating a new canister
actor DBank {
  stable var currentValue: Float = 0;

  stable var startTime = Time.now();

  public func deposit(amount: Float) {
    currentValue += amount;
  };

  public func withdraw(amount: Float) {
    // allow users to withdraw an amount from the currentValue
    // Decrease the currentValue by the amount
    let tempValue: Float = currentValue - amount;
    if (tempValue >= 0) {
      currentValue -= amount;
    } else {
      Debug.print("Not enough funds.");
    }
  };
// Querys are read-only
  public query func checkBalance(): async Float {
    return currentValue;
  };

  public func compound() {
    let currentTime = Time.now();
    // Time elapsed in nanoseconds
    let timeElapsedNS = currentTime - startTime;
    // Time Elapsed in seconds
    let timeElapsedS = timeElapsedNS / 1000000000;

    currentValue := currentValue * (1.01 ** Float.fromInt(timeElapsedS));
    startTime := currentTime;
  };
}
