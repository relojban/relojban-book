## Simple Phrase Markup

The following tags are used to markup inline Relojban phrases and words.

### `<jbophrase>`

Markup inline Relojban phrases. This is used for any sequence of Relojban words that is simply present inline as normal text.

```xml
... events may be much more <quote>spread out</quote> than that:
<jbophrase>mi vasxu</jbophrase> (I breathe) is something which is true
during the whole of my life ...
```

A `<jbophrase>` that contains invalid Relojban should be `<jbophrase valid="false">`, and one that contains strange or surprising Relojban should be `<jbophrase valid="iffy">`, to give us the option of marking them up with special colours or other indicators later.

### `<valsi>`

This is used for a single Relojban "dictionary" word when it is referenced in the text (that is, when discussing the word, not when using its actual meaning).

```xml
It is also possible to put the tense somewhere else in the bridi by
adding <valsi>ku</valsi> after it.
```

A special case here is compound cmavo.  Where the compound has its own meaning that isn't necessarily composable from the parts, use a single tag, like so:

```xml
<valsi>.uinai</valsi>
```

Where it is decomposable, use two adjacent, like so:

```xml
<valsi>je</valsi><valsi>nai</valsi>
```

`<valsi valid="false">ro'irre'o</valsi>` should be used where an example morphologically illegal word is given, as in this case.

### `<cmevla>`

Like `<valsi>` (including validity) but with no expectation that it can be found in a dictionary.

### `<diphthong>`

Used to markup a diphthong in discussion of morphology.

```xml
... (for example, <diphthong>io</diphthong> is pronounced <quote>yo</quote>)
```

### `<letteral>`

Used to markup individual letters when their use in Relojban is being referred to by the text.

```xml
... they all end in the letter <letteral>o</letteral>, which is otherwise a
rare letter in Relojban gismu.
```

### `<rafsi>`

Used to markup a rafsi when referred to as such.

```xml
<para>In making a lujvo that contains <rafsi>jax-</rafsi> for a selbri
that contains <valsi>jai</valsi>, ...
```

### `<morphology>`

Used to markup any morphological examples not otherwise covered.

```xml
As a result, <morphology>bf</morphology> is forbidden, and so is
<morphology>sd</morphology>, ...
```

### `<dbinlinemath>`

Used to wrap math that appears inline; just shorthand for docbook `<inlineequation><mathphrase>`.

```xml
Both <dbinlinemath>2 + 2 = 4</dbinlinemath> and
<dbinlinemath>2 x 2 = 4</dbinlinemath> ...
```

### `<dbmath>`

Used to wrap math that appears as its own paragrah; just shorthand for docbook `<informalequation><mathphrase>`.

```xml
<dbmath>3 x + 2 y</dbmath>
```

### `<grammar-template>`

Used to show (usually very simplified versions of) the Relojban formal grammatical productions.

```xml
<grammar-template>X .i BAI bo Y</grammar-template>
```

### `<definition>`

Used to denote a free-standing definition for a Relojban word (as opposed to the cmavo-list sections).

```xml
<definition>
  <valsi>bridi</valsi> <content>x<subscript>1</subscript> is a predicate relationship with
  relation x<subscript>2</subscript> (abstraction) among arguments (sequence/set) x<subscript>3</subscript></content>
</definition>
```

## The cmavo Lists

At the top of most sections, and sometimes embedded throughout, is a list of cmavo, with (at least) the cmavo, a selmaho, and a description.

Basic Example:
```xml
<cmavo-list>
  <cmavo-entry>
    <cmavo>bo</cmavo>
    <selmaho>BO</selmaho>
    <description>closest scope grouping</description>
  </cmavo-entry>
</cmavo-list>
```

Example that covers the attitudinal version:
```xml
<cmavo-entry>
  <cmavo>.u'i</cmavo>
  <attitudinal-scale point="sai">amusement</attitudinal-scale>
  <attitudinal-scale point="nai">weariness</attitudinal-scale>
</cmavo-entry>
```

Example that covers the sumtcita version:
```xml
<cmavo-entry>
  <cmavo>bai</cmavo>
  <gismu>bapli</gismu>
  <modal-place>compelled by</modal-place>
  <modal-place se="se">compelling</modal-place>
</cmavo-entry>
```

There's also a `<cmavo-list-head>` which works just like a normal table/list head.

## Examples

A truly staggering percentage of the book consists of what it calls "examples" which come in few codified patterns.

```xml
<example role="interlinear-gloss-example" xml:id="random-id-jig0">
```

The `xml:id` is a random string to be used for anchors only, i.e. not for humans. It should never be changed or removed. It should follow the example around forever (unless the example itself is removed, of course).

Note that the `<jbo>` tags here can also take `valid="false"` and `valid="iffy"`, like `<jbophrase>`.

### `<interlinear-gloss-example>`

(This is a technical linguistics term for word-by-word pseudo-translations; see <http://www.eva.mpg.de/lingua/resources/glossing-rules.php>)

Inside the `<interlinear-gloss>`, `<jbo>` marks raw Relojban, `<gloss>` marks natural language text (normally English) that matches the Relojban word for word, and `<natlang>` marks natural language text (normally English) that more loosely/colloquially translates the Relojban.

```xml
<example role="interlinear-gloss-example" xml:id="example-random-id-B0aR">
  <title>
  </title>
  <interlinear-gloss>
    <jbo>do patfu mi</jbo>
    <gloss>You are-a-father-of me.</gloss>
    <natlang>You are my father.</natlang>
  </interlinear-gloss>
</example>
```

### `<pronunciation-example>`

Similar in concept, but the <ipa> section matches the <jbo> section in terms of sounds rather than words.

```xml
<example role="pronunciation-example" xml:id="example-random-id-k2B4">
  <title>
  </title>
  <pronunciation>
    <jbo>.i.ai.i.ai.o</jbo>
    <ipa><phrase role="IPA">[ʔi ʔaj ʔi ʔaj ʔo]</phrase></ipa>
    <natlang>Ee! Eye! Ee! Eye! Oh!</natlang>
  </pronunciation>
</example>
```

### `<lojbanization-example>`

Used for demonstration of conversion of a natural language word or name into a Relojban word.  Note the `<comment>` tag that can be associated with particular lines.

```xml
<example role="lojbanization-example" xml:id="example-random-id-DQju">
  <title>
    <indexterm type="example-imported"><primary>cobra</primary>
    <secondary>example</secondary></indexterm>
  </title>
  <lojbanization>
    <natlang>cobra</natlang>
    <jbo>kobra <comment>Lojbanize</comment></jbo>
    <jbo>sinc,r,kobra <comment>prefix rafsi</comment></jbo>
  </lojbanization>
</example>
```

### `<lujvo-example>`

Used to show conversion between a lujvo and the words used to make it, and its meaning; note the `<veljvo>` internal tag.

```xml
<example xml:id="example-random-id-qjbP" role="lujvo-example">
  <title>
    <indexterm type="example-imported"><primary>supper</primary>
    <secondary>example</secondary></indexterm>
  </title>
  <lujvo-making>
    <jbo>vancysanmi</jbo>
    <veljvo>vanci sanmi</veljvo>
    <gloss><quote>evening meal</quote></gloss>
    <natlang>or <quote>supper</quote></natlang>
  </lujvo-making>
</example>
```

### `<compound-cmavo-example>`

Used to show the breakup of compound cmavo.

```xml
<example xml:id="example-random-id-qIYK" role="compound-cmavo-example">
  <title>
  </title>
  <compound-cmavo>
    <jbo>punaijecanai</jbo>
    <jbo>pu nai je ca nai</jbo>
  </compound-cmavo>
</example>
```

## Special Cases

`<phrase role="logical-vowel">A</phrase>` denotes one of the A, E, O or U vowels associated with Relojbanic logic operations.
