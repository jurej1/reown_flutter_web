// importing all the chains
import * as Chains from "@reown/appkit/networks";

/// maps chainIds to Chains and Always returns at least one chain
/// return type is actually a "Tuple"
export function chainsFromIds(
  chainIds: number[]
): [Chains.Chain, ...Chains.Chain[]] {
  const chainsArray = chainIds
    .map((chainId) => {
      // map number to chains
      return chainFromId(chainId);
    })
    .filter((val) => {
      // remove all undefined chains
      return val !== undefined;
    });

  if (chainsArray.length === 0)
    throw new Error("chains must contain at least one chain");

  return [chainsArray[0], ...chainsArray.slice(1)];
}

/// maps id to Chain or undefined (if chain not found)
export function chainFromId(chainId: number): Chains.Chain | undefined {
  // "Chains" is an map of Chains
  // Object.values turns that map into array where each element
  // is an map containing the data about the chain
  for (const chain of Object.values(Chains)) {
    // does id Exist
    if ("id" in chain) {
      if (chain.id === chainId) {
        return chain;
      }
    }
  }

  // when chain not found or does not exist
  throw new Error(`Chain with id:[${chainId}] was not found.`);
}
