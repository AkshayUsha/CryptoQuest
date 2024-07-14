using UnityEngine;
using UnityEngine.UI;

public class UIManager : MonoBehaviour
{
    public Text statusText;

    public void UpdateStatus(string status)
    {
        statusText.text = status;
    }
}
