const checkboxes = document.querySelectorAll('input[type="checkbox"]');

checkboxes.forEach(tagCheckbox => {
  tagCheckbox.addEventListener('filter', function() {
    const checkedTags = Array.from(checkboxes)
      .filter(checkbox => checkbox.checked)
      .map(checkbox => checkbox.name);
      console.log(checkedTags)

    const urlParams = new URLSearchParams(window.location.search);

    if (checkedTags.length > 0) {
      urlParams.set('q', checkedTags.join(','));
    } else {
      urlParams.delete('q');
    }

    history.replaceState(null, null, `?${urlParams.toString()}`);
  });
});
