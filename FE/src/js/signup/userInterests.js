import { getElements } from '../util/commonUtil.js';
import { STATE_LOG, FORM_RULES } from '../constants/constant.js';

const tags = [];

export function addInterests({ key }, tagUiWrap, signupInterests) {
    if (key === ',') {
        const interest = signupInterests.value.replace(/[,]/g, '');
        signupInterests.value = '';
        if (!interest) return checkInterests();
        tags.push(interest);
        return updateTag(tagUiWrap);
    }
    return checkInterests();
}

export function removeInterests({ key }, tagUiWrap, signupInterests) {
    if (tags.length > 0 && signupInterests.value === '' && (key === 'Backspace' || key === 'Delete')) {
        signupInterests.value = tags.pop() + ' ';
        return updateTag(tagUiWrap);
    }
    return checkInterests();
}

export function removeInterestsOnClick({ target }, tagUiWrap) {
    if (target.classList.contains('tag-ui-close')) {
        const data = target.getAttribute('data-item');
        const index = tags.indexOf(data);
        tags.splice(index, 1);
        return updateTag(tagUiWrap);
    }
    return checkInterests();
}

export function resetTag() {
    getElements('.tag-ui').forEach(tag => tag.parentElement.removeChild(tag));
}

function checkInterests() {
    if (tags.length < FORM_RULES.INTERESTS_MIN) return STATE_LOG.INVALID.INTERESTS;
    return STATE_LOG.VALID.BASE;
}

function createTag(interest) {
    const tag = document.createElement('span');
    tag.setAttribute('class', 'tag-ui');
    tag.innerHTML = `${interest}<span class="tag-ui-close" data-item="${interest}">✖</span>`;
    return tag;
}

function updateTag(tagUiWrap) {
    resetTag();
    tags.slice().reverse().forEach(tag => tagUiWrap.prepend(createTag(tag)));
    return checkInterests();
}