using System.Threading.Tasks;
using Nethereum.Web3;
using UnityEngine;

public class NFTManager : MonoBehaviour
{
    private string rpcUrl = "https://mainnet.infura.io/v3/YOUR_INFURA_PROJECT_ID";
    private string contractAddress = "YOUR_CONTRACT_ADDRESS";
    private Web3 web3;

    void Start()
    {
        web3 = new Web3(rpcUrl);
    }

    public async Task CreateNFT(string playerAddress, string tokenURI)
    {
        var createNFTFunction = new CreateNFTFunction
        {
            PlayerAddress = playerAddress,
            TokenURI = tokenURI
        };

        var transactionReceipt = await web3.Eth.GetContractTransactionHandler<CreateNFTFunction>()
            .SendRequestAndWaitForReceiptAsync(contractAddress, createNFTFunction);

        Debug.Log("NFT Created: " + transactionReceipt.TransactionHash);
    }
}
