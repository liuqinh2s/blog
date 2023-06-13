{% if theme.utterance and theme.utterance.enable %}

<script type="text/javascript">
(function(){
    var e=document.createElement("script");
    e.type="text/javascript",
    e.async=!0,
    e.setAttribute("issue-term","{{ theme.utterance.issue_term }}"),
    e.setAttribute("theme","{{ theme.utterance.theme }}"),
    e.setAttribute("repo","{{ theme.utterance.repo }}"),
    e.crossorigin="anonymous",
    e.src="https://utteranc.es/client.js";
    var utterance_container = document.getElementById("utterance-container");
    utterance_container && utterance_container.appendChild(e);
    })()
</script>
{% endif %}